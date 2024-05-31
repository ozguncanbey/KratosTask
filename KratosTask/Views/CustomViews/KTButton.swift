//
//  KTButton.swift
//  KratosTask
//
//  Created by Özgün Can Beydili on 31.05.2024.
//

import UIKit

final class KTButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String) {
        super.init(frame: .zero)
        configure()
        self.setTitle(title, for: .normal)
    }
    
    private func configure() {
        layer.cornerRadius = 10
        
        setTitleColor(UIColor.black, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        
        backgroundColor = .systemYellow
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
