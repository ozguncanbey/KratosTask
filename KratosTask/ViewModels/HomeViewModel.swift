//
//  HomeViewModel.swift
//  KratosTask
//
//  Created by Özgün Can Beydili on 31.05.2024.
//

import Foundation

// MARK: - Protocol
protocol HomeViewModelProtocol {
    var view: HomeScreenProtocol? { get set }
    func viewDidLoad()
}

final class HomeViewModel {
    weak var view: HomeScreenProtocol?
}

// MARK: - Extension
extension HomeViewModel: HomeViewModelProtocol {
    
    func viewDidLoad() {
        view?.configureVC()
        view?.buttonsTapped()
    }
}
