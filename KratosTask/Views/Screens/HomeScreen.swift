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
    func buttonsTapped()
}

final class HomeScreen: UIViewController {

    // MARK: - Variables
    private let viewModel = HomeViewModel()
    
    private let onlyLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Homer Simpson"
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.textColor = .systemYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let logoutButton = KTButton(title: "Logout")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Extensions
extension HomeScreen: HomeScreenProtocol {
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        
        addSubviews()
        layoutUI()
    }
    
    private func addSubviews() {
        view.addSubview(onlyLabel)
        view.addSubview(logoutButton)
    }

    private func layoutUI() {
        NSLayoutConstraint.activate([
            onlyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onlyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 2 * -CGFloat.padding),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat.padding),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat.padding),
            logoutButton.heightAnchor.constraint(equalToConstant: 2.5 * CGFloat.padding)
        ])
    }
    
    func buttonsTapped() {
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    @objc private func logoutButtonTapped() {
        
    }
}
