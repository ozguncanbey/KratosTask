//
//  KTTextField.swift
//  KratosTask
//
//  Created by Özgün Can Beydili on 31.05.2024.
//

import UIKit

final class KTTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholder: String) {
        super.init(frame: .zero)
        configure()
        self.placeholder = placeholder
    }
    
    private func configure() {
        layer.cornerRadius = 10
        //        layer.borderWidth = 2
        //        layer.borderColor = UIColor.systemYellow.cgColor
        
        textColor = .label
        tintColor = .label
        
        textAlignment = .natural
        font = UIFont.preferredFont(forTextStyle: .title3)
        backgroundColor = .tertiarySystemBackground
        
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 8
        
        autocorrectionType = .no
        autocapitalizationType = .none
        spellCheckingType = .no
        keyboardType = .emailAddress
        returnKeyType = .next
        textContentType = .oneTimeCode
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
