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
    
    override func loadView() {
        view = appView
        appView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    internal func didUserPressRecognizeButton() {

    }
}
