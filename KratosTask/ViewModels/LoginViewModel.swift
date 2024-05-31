//
//  LoginViewModel.swift
//  KratosTask
//
//  Created by Özgün Can Beydili on 31.05.2024.
//

import Foundation

// MARK: - Protocol
protocol LoginViewModelProtocol {
    var view: LoginScreenProtocol? { get set }
    func viewDidLoad()
}

final class LoginViewModel {
    weak var view: LoginScreenProtocol?
}

// MARK: - Extension
extension LoginViewModel: LoginViewModelProtocol {
    func viewDidLoad() {
        view?.configureVC()
    }
}
