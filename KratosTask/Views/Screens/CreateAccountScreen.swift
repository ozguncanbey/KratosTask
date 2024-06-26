//
//  CreateAccountScreen.swift
//  KratosTask
//
//  Created by Özgün Can Beydili on 31.05.2024.
//

import UIKit
import Firebase
import FirebaseFirestore

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
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: CGFloat.padding),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat.padding),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat.padding),
            nameTextField.heightAnchor.constraint(equalToConstant: 2.5 * CGFloat.padding),
            
            surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: CGFloat.padding),
            surnameTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            surnameTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            surnameTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: CGFloat.padding),
            emailTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: CGFloat.padding),
            passwordTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -CGFloat.padding),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat.padding),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat.padding),
            cancelButton.heightAnchor.constraint(equalToConstant: 2.5 * CGFloat.padding),
            
            createAccountButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -CGFloat.padding),
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
        nameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        if !nameTextField.hasText, !surnameTextField.hasText, !emailTextField.hasText, !passwordTextField.hasText {
            presentAlertOnMainThread(title: "Fill the Blanks!", message: "Please make sure that all the blanks are filled.", buttonTitle: "Ok")
        } else {
            // authentication part
            Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { result, error in
                guard let result = result, error == nil else {
                    self.presentAlertOnMainThread(title: "Error!", message: error?.localizedDescription ?? "Unexpected error! Make sure everything is correct.", buttonTitle: "Ok")
                    return
                }
                
                // store the users info
                let db = Firestore.firestore()
                db.collection("users").document(result.user.uid).setData([
                    "name": self.nameTextField.text!,
                    "surname": self.surnameTextField.text!,
                    "email": self.emailTextField.text!
                ]) { error in
                    if let error = error {
                        self.presentAlertOnMainThread(title: "Error!", message: error.localizedDescription, buttonTitle: "Ok")
                    } else {
                        self.presentAlertOnMainThread(title: "Done!", message: "Your account was created successfully.", buttonTitle: "Ok")
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
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
