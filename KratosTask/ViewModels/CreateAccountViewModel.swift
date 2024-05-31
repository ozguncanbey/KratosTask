//
//  CreateAccountViewModel.swift
//  KratosTask
//
//  Created by Özgün Can Beydili on 31.05.2024.
//

import Foundation

// MARK: - Protocol
protocol CreateAccountViewModelProtocol {
    var view: CreateAccountScreenProtocol? { get set }
    func viewDidLoad()
}

final class CreateAccountViewModel {
    weak var view: CreateAccountScreenProtocol?
}

// MARK: - Extension
extension CreateAccountViewModel: CreateAccountViewModelProtocol {
    
    func viewDidLoad() {
        view?.configureVC()
        view?.buttonsTapped()
    }
}
