//
//  HomeScreen.swift
//  KratosTask
//
//  Created by Özgün Can Beydili on 31.05.2024.
//

import UIKit
import Firebase
import FirebaseFirestore

// MARK: - Protocol
protocol HomeScreenProtocol: AnyObject {
    func configureVC()
    func loadUserData()
    func buttonsTapped()
}

final class HomeScreen: UIViewController {

    // MARK: - Variables
    private let viewModel = HomeViewModel()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        
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
        view.addSubview(nameLabel)
        view.addSubview(logoutButton)
    }

    private func layoutUI() {
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 2 * -CGFloat.padding),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat.padding),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat.padding),
            logoutButton.heightAnchor.constraint(equalToConstant: 2.5 * CGFloat.padding)
        ])
    }
    
    func loadUserData() {
        guard let user = Auth.auth().currentUser else { return }
        let db = Firestore.firestore()
        
        db.collection("users").document(user.uid).getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                let name = data?["name"] as? String ?? ""
                let surname = data?["surname"] as? String ?? ""
                
                DispatchQueue.main.async { [weak self] in
                    self?.nameLabel.text = "\(name) \(surname)"
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func buttonsTapped() {
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    @objc private func logoutButtonTapped() {
        
        let alert = UIAlertController(title: "Log Out!", message: "Are you sure you want to log out?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            
            do {
                try FirebaseAuth.Auth.auth().signOut()
                
                navigationController?.popViewController(animated: true)
            } catch {
                print(error.localizedDescription)
            }
        }))
    
        present(alert, animated: true)
    }
}
