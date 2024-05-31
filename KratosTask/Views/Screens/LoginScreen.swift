//
//  LoginScreen.swift
//  KratosTask
//
//  Created by Özgün Can Beydili on 31.05.2024.
//

import UIKit

// MARK: - Protocol
protocol LoginScreenProtocol: AnyObject {
    func configureVC()
}

final class LoginScreen: UIViewController {

    // MARK: - Variables
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

// MARK: - Extension
extension LoginScreen: LoginScreenProtocol {
    
    func configureVC() {
        view.backgroundColor = .yellow
    }
}
