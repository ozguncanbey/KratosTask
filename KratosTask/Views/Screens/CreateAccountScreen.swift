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
    func buttonsTapped()
}

final class CreateAccountScreen: UIViewController {

    // MARK: - Variables
    private let viewModel = CreateAccountViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Create Account"
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.textColor = .systemYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nameTextField = KTTextField(placeholder: "Name")
    private let surnameTextField = KTTextField(placeholder: "Surname")
    private let emailTextField = KTTextField(placeholder: "Email Address")
    private let passwordTextField = KTTextField(placeholder: "Password")
    
    private let createAccountButton = KTButton(title: "Create Account")
    private let cancelButton = KTButton(title: "Cancel")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        clearAll()
    }
}

// MARK: - Extensions
extension CreateAccountScreen: CreateAccountScreenProtocol {
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        UIView.dismissKeyboard(view: view)
        
        nameTextField.delegate = self
        surnameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        passwordTextField.isSecureTextEntry = true
        
        cancelButton.backgroundColor = .systemRed
        cancelButton.setTitleColor(.white, for: .normal)
        
        addSubviews()
        layoutUI()
    }
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(nameTextField)
        view.addSubview(surnameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(createAccountButton)
        view.addSubview(cancelButton)
    }
    
    private func layoutUI() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameTextField.heightAnchor.constraint(equalToConstant: 2.5 * padding),
            
            surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: padding),
            surnameTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            surnameTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            surnameTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: padding),
            emailTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: padding),
            passwordTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            cancelButton.heightAnchor.constraint(equalToConstant: 2.5 * padding),
            
            createAccountButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -padding),
            createAccountButton.leadingAnchor.constraint(equalTo: cancelButton.leadingAnchor),
            createAccountButton.trailingAnchor.constraint(equalTo: cancelButton.trailingAnchor),
            createAccountButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor),
        ])
    }
    
    func buttonsTapped() {
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    @objc private func createAccountButtonTapped() {
        
    }
    
    @objc private func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func clearAll() {
        nameTextField.text = ""
        surnameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
    }
}

extension CreateAccountScreen: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameTextField {
            surnameTextField.becomeFirstResponder()
        } else if textField == surnameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            createAccountButtonTapped()
        }
        
        return true
    }
}
