//
//  LaunchViewModel.swift
//  KratosTask
//
//  Created by Özgün Can Beydili on 31.05.2024.
//

import Foundation

// MARK: - Protocol
protocol LaunchViewModelProtocol {
    var view: LaunchScreenProtocol? { get set }
    func viewDidLoad()
}

final class LaunchViewModel {
    weak var view: LaunchScreenProtocol?
}

// MARK: - Extensions
extension LaunchViewModel: LaunchViewModelProtocol {
    
    func viewDidLoad() {
        view?.configureVC()
        view?.playGif()
    }
}
