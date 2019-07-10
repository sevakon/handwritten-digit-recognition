//
//  DrawingViewController.swift
//  HandwrittenDigitRecognition
//
//  Created by Vsevolod Konyakhin on 05/07/2019.
//  Copyright © 2019 Vsevolod Konyakhin. All rights reserved.
//

import UIKit
import TensorFlowLite

class AppViewController: UIViewController, AppViewDelegate {
    
    private var appView = AppView()
    private var modelDataHandler: ModelDataHandler?
    
    override func loadView() {
        view = appView
        modelDataHandler = ModelDataHandler(modelFileInfo: MobileNet.advancedModelInfo)
        appView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    internal func didUserPressRecognizeButton(with image: UIImageView) {
        guard modelDataHandler != nil else {return}
        
        let modelResult = modelDataHandler!.runModel(with: image)
        
        guard let predictedDigit = modelResult.predictedDigit else {return}
        guard let probability = modelResult.probability else {return}
        
        DispatchQueue.main.async {
            self.appView.updateDigitLabel(with: predictedDigit, probability: probability)
        }
    }
}
