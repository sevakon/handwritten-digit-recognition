//
//  DrawingImageView.swift
//  HandwrittenDigitRecognition
//
//  Created by Vsevolod Konyakhin on 05/07/2019.
//  Copyright © 2019 Vsevolod Konyakhin. All rights reserved.
//

import UIKit

class DrawingImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
