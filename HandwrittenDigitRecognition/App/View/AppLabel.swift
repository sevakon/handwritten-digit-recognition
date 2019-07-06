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
        text = "It's 5"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
