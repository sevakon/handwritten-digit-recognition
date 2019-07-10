//
//  AppLabel.swift
//  HandwrittenDigitRecognition
//
//  Created by Vsevolod Konyakhin on 06/07/2019.
//  Copyright © 2019 Vsevolod Konyakhin. All rights reserved.
//

import UIKit

class AppLabel: UILabel {

    init() {
        super.init(frame: .zero)
        textColor = .customRed
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: "HelveticaNeue-Medium", size: 50)
        textAlignment = NSTextAlignment.center
        text = "It's ..."
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func updateLabel(with number: Int, probability: Float) {
        guard number < 10 && number >= 0 else {
            print("Given number is out of expected range (0-9)")
            return
        }
        
        self.text = "It's \(number) with \(Int(probability * 100))%"
    }
    
    internal func resetLabel() {
        self.text = "It's ..."
    }
}
