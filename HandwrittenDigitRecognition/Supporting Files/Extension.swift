//
//  Extension.swift
//  HandwrittenDigitRecognition
//
//  Created by Vsevolod Konyakhin on 07/07/2019.
//  Copyright © 2019 Vsevolod Konyakhin. All rights reserved.
//

import UIKit

extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {
        
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    func getPixelAplha(pos: CGPoint) -> Float {
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let alpha = Float(data[pixelInfo+3]) / Float(255.0)
        
        return alpha
    }
    
    func buffer() -> CVPixelBuffer? {
        var pixelBuffer: CVPixelBuffer?
        let width = Int(self.size.width)
        let height = Int(self.size.height)
        
        let status = CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_OneComponent8, nil, &pixelBuffer)
        guard let pxBuffer = pixelBuffer, status == kCVReturnSuccess else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pxBuffer, CVPixelBufferLockFlags(rawValue:0))
        let pixelData = CVPixelBufferGetBaseAddress(pxBuffer)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pxBuffer)
        
        if let bitmapContext = CGContext(data: pixelData, width: width, height: height, bitsPerComponent: 8, bytesPerRow:bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue), let cgImage = self.cgImage {
            let rect = CGRect(x: 0, y: 0, width: width, height: height)
            bitmapContext.draw(cgImage, in: rect)
            
            return pxBuffer
        } else {
            return nil
        }
    }
}

extension Data {
    init<T>(copyingBufferOf array: [T]) {
        self = array.withUnsafeBufferPointer(Data.init)
    }
}

extension Array {
    init?(unsafeData: Data) {
        guard unsafeData.count % MemoryLayout<Element>.stride == 0 else { return nil }
        #if swift(>=5.0)
        self = unsafeData.withUnsafeBytes { .init($0.bindMemory(to: Element.self)) }
        #else
        self = unsafeData.withUnsafeBytes {
            .init(UnsafeBufferPointer<Element>(
                start: $0,
                count: unsafeData.count / MemoryLayout<Element>.stride
            ))
        }
        #endif  // swift(>=5.0)
    }
}



