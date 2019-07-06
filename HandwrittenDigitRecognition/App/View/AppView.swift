//
//  AppView.swift
//  HandwrittenDigitRecognition
//
//  Created by Vsevolod Konyakhin on 06/07/2019.
//  Copyright © 2019 Vsevolod Konyakhin. All rights reserved.
//

import UIKit

class AppView: UIView {
    
    private var imageView: DrawingImageView
    
    private let backgroundImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customRed
        return view
    }()
    
    private let recognizeButton: AppButton
    private let clearButton: AppButton
    
    private var digitLabel: AppLabel
    
    init() {
        imageView = DrawingImageView()
        recognizeButton = AppButton(text: "Recognize", textColor: .black)
        clearButton = AppButton(text: "Clear", textColor: .customRed)
        digitLabel = AppLabel()
        super.init(frame: .zero)
        initViews()
        setupConstraints()
    }
    
    private func initViews() {
        self.backgroundColor = .customPink
        
        addSubview(backgroundImageView)
        addSubview(imageView)
        
        addSubview(recognizeButton)
        addSubview(clearButton)
//        clearButton.addTarget(self, action: , for: )
//        recognizeButton.addTarget(self, action: , for: )
        
        addSubview(digitLabel)
    }
    
    private func setupConstraints() {
        backgroundImageView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: backgroundImageView.widthAnchor).isActive = true
        backgroundImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: backgroundImageView.widthAnchor, constant: -3).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        
        clearButton.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        clearButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
        clearButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        clearButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        recognizeButton.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        recognizeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        recognizeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        recognizeButton.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -15).isActive = true
        
        digitLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        digitLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        digitLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor).isActive = true
        digitLabel.bottomAnchor.constraint(equalTo: recognizeButton.topAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
