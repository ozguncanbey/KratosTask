//
//  HomeScreen.swift
//  KratosTask
//
//  Created by Özgün Can Beydili on 31.05.2024.
//

import UIKit

// MARK: - Protocol
protocol HomeScreenProtocol: AnyObject {
    func configureVC()
}

final class HomeScreen: UIViewController {

    // MARK: - Variables
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

// MARK: - Extensions
extension HomeScreen: HomeScreenProtocol {
    
    func configureVC() {
        view.backgroundColor = .green
    }
}
