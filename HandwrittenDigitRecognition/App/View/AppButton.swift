//
//  AppButton.swift
//  HandwrittenDigitRecognition
//
//  Created by Vsevolod Konyakhin on 06/07/2019.
//  Copyright © 2019 Vsevolod Konyakhin. All rights reserved.
//

import UIKit

class AppButton: UIButton {
    
    private let upperLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customGrey
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customGrey
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(text: String, textColor: UIColor) {
        super.init(frame: .zero)
        backgroundColor = .white
        setTitle(text, for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        translatesAutoresizingMaskIntoConstraints = false
        
        initViews()
        setupLinesConstraints()
    }
    
    private func initViews() {
        addSubview(upperLine)
        addSubview(bottomLine)
    }
    
    private func setupLinesConstraints() {
        upperLine.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        upperLine.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        upperLine.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 1).isActive = true
        upperLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        bottomLine.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bottomLine.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        bottomLine.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -1).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
