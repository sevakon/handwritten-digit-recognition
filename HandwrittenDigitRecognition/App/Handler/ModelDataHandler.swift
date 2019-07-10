//
//  AIManager.swift
//  HandwrittenDigitRecognition
//
//  Created by Vsevolod Konyakhin on 06/07/2019.
//  Copyright © 2019 Vsevolod Konyakhin. All rights reserved.
//

import TensorFlowLite

typealias FileInfo = (name: String, extension: String)

enum MobileNet {
    static let baseModelInfo: FileInfo = (name: "baseline_model", extension: "tflite")
    static let advancedModelInfo: FileInfo = (name: "advanced_model", extension: "tflite")
}

enum ImageForInfering {
    static let width = 28
    static let height = 28
    static let size = CGSize(width: 28, height: 28)
}

final class ModelDataHandler {
    
    private var interpreter: Interpreter
    
    init?(modelFileInfo: FileInfo) {
        let modelFilename = modelFileInfo.name

        guard let modelPath = Bundle.main.path(
            forResource: modelFilename,
            ofType: modelFileInfo.extension
            ) else {
                print("Failed to load the model file with name: \(modelFilename).")
                return nil
        }

        do {
            interpreter = try Interpreter(modelPath: modelPath)
            try interpreter.allocateTensors()
        } catch let error {
            print("Failed to create the interpreter with error: \(error.localizedDescription)")
            return nil
        }

    }
    
    internal func runModel(with imageView: UIImageView) -> (predictedDigit: Int?, probability: Float?) {
        
        guard let image = imageView.image else {return (nil, nil)}
        
        guard let scaledImage = resizeImage(image: image, targetSize: ImageForInfering.size) else {
            return (nil, nil)
        }
        guard let greyImage = convertToGrayScale(image: scaledImage) else {return (nil, nil)}
        
        guard let pixelArray = pixelValuesFromImage(imageRef: greyImage.cgImage) else {return (nil, nil)}

        let data = Data(copyingBufferOf: normalizedFloatArray(from: pixelArray))
        
        let outputTensor: Tensor

        do {
            try interpreter.copy(data, toInputAt: 0)

            try interpreter.invoke()

            outputTensor = try interpreter.output(at: 0)
        } catch let error {
            print("Failed to invoke the interpreter with error: \(error.localizedDescription)")
            return (nil, nil)
        }
        
        let results = [Float32](unsafeData: outputTensor.data) ?? []
            
        guard let maxProbability = results.max() else {return (nil, nil)}
        
        guard let predictedDigit = results.firstIndex(of: maxProbability) else {return (nil, nil)}
        
        return (predictedDigit, maxProbability)
    }
    
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    private func convertToGrayScale(image: UIImage) -> UIImage? {
        let imageRect:CGRect = CGRect(origin: CGPoint.zero, size: CGSize(width: image.size.width, height:  image.size.height))
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = image.size.width
        let height = image.size.height
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        if let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: ImageForInfering.width, space: colorSpace, bitmapInfo: bitmapInfo.rawValue), let cgImage = image.cgImage?.copy() {
            context.setFillColor(gray: 1, alpha: 1)
            context.fill(imageRect)
            context.draw(cgImage, in: imageRect)
            
            if let imageRef = context.makeImage() {
                let newImage = UIImage(cgImage: imageRef)
                return newImage
            }
        }
        return nil
    }
    
    private func pixelValuesFromImage(imageRef: CGImage?) -> [UInt8]? {
        var width = 0
        var height = 0
        var pixelValues: [UInt8]?
        if let imageRef = imageRef {
            width = imageRef.width
            height = imageRef.height
            let bitsPerComponent = imageRef.bitsPerComponent
            let bytesPerRow = imageRef.bytesPerRow
            let totalBytes = height * bytesPerRow
            
            let colorSpace = CGColorSpaceCreateDeviceGray()
            pixelValues = [UInt8](repeating: 0, count: totalBytes)
            
            let contextRef = CGContext(data: &pixelValues!, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: 0)
            contextRef?.draw(imageRef, in: CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height)))
        }
        
        return pixelValues
    }
    
    private func normalizedFloatArray(from array: [UInt8]) -> [Float] {
        var resultArray = [Float]()
        
        array.forEach{resultArray.append(Float($0)/255.0)}
        resultArray = resultArray.map{ Float(1 - $0)}
        
        return resultArray
        
    }
    
}


