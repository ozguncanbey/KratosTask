//
//  KTCheckBox.swift
//  KratosTask
//
//  Created by Özgün Can Beydili on 31.05.2024.
//

import UIKit

final class KTCheckbox: UIButton {
    
    private let checkedImage = UIImage(systemName: "checkmark.square.fill")
    private let uncheckedImage = UIImage(systemName: "square")
    
    var isChecked: Bool = false {
        didSet {
            self.updateImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = .systemYellow
        
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.updateImage()
    }
    
    @objc func buttonTapped() {
        isChecked = !isChecked
    }
    
    private func updateImage() {
        let image = isChecked ? checkedImage : uncheckedImage
        self.setImage(image, for: .normal)
    }
}
