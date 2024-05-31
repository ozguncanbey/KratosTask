//
//  CreateAccountScreen.swift
//  KratosTask
//
//  Created by Özgün Can Beydili on 31.05.2024.
//

import UIKit

// MARK: - Protocol
protocol CreateAccountScreenProtocol: AnyObject {
    func configureVC()
}

final class CreateAccountScreen: UIViewController {

    // MARK: - Variables
    private let viewModel = CreateAccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

// MARK: - Extension
extension CreateAccountScreen: CreateAccountScreenProtocol {
    
    func configureVC() {
        view.backgroundColor = .gray
    }
}
