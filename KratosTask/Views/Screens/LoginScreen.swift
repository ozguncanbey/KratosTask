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
    func buttonsTapped()
}

final class LoginScreen: UIViewController {
    
    // MARK: - Variables
    private let viewModel = LoginViewModel()
    
    private var logoImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(resource: .logo)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(resource: .background)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let emailTextField = KTTextField(placeholder: "Email Address")
    private let passwordTextField = KTTextField(placeholder: "Password")
    
    private let checkBox = KTCheckbox()
    
    private let rememberMeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Remember me"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(.systemYellow, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let loginButton = KTButton(title: "Login Now")
    
    private let createOneLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Don't have an account?"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let createOneButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Create One", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.systemYellow, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
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
extension LoginScreen: LoginScreenProtocol {
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        UIView.dismissKeyboard(view: view)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        passwordTextField.isSecureTextEntry = true
        
        addSubviews()
        layoutUI()
    }
    
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(logoImageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(checkBox)
        view.addSubview(rememberMeLabel)
        view.addSubview(forgotPasswordButton)
        view.addSubview(loginButton)
        view.addSubview(createOneLabel)
        view.addSubview(createOneButton)
    }
    
    private func layoutUI() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 300),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            
            emailTextField.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 4 * CGFloat.padding),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat.padding),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat.padding),
            emailTextField.heightAnchor.constraint(equalToConstant: 2.5 * CGFloat.padding),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: CGFloat.padding),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 2.5 * CGFloat.padding),
            
            checkBox.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: CGFloat.padding / 1.3),
            checkBox.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            
            rememberMeLabel.centerYAnchor.constraint(equalTo: checkBox.centerYAnchor),
            rememberMeLabel.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: CGFloat.padding / 2),
            
            forgotPasswordButton.centerYAnchor.constraint(equalTo: checkBox.centerYAnchor),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat.padding),
            
            loginButton.topAnchor.constraint(equalTo: rememberMeLabel.bottomAnchor, constant: CGFloat.padding),
            loginButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 2.5 * CGFloat.padding),
            
            createOneLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 2 * CGFloat.padding),
            createOneLabel.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor, constant: 2 * CGFloat.padding),
            
            createOneButton.centerYAnchor.constraint(equalTo: createOneLabel.centerYAnchor),
            createOneButton.leadingAnchor.constraint(equalTo: createOneLabel.trailingAnchor, constant: CGFloat.padding)
        ])
    }
    
    func buttonsTapped() {
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        createOneButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
    }
    
    @objc private func forgotPasswordButtonTapped() {
        presentAlertOnMainThread(title: "Link Sent!", message: "Click on the link in your email to reset your password.", buttonTitle: "Ok")
    }
    
    @objc private func loginButtonTapped() {
        
    }
    
    @objc private func createAccountButtonTapped() {
        navigationController?.pushViewController(CreateAccountScreen(), animated: true)
    }
    
    private func clearAll() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
}

extension LoginScreen: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            loginButtonTapped()
        }
        
        return true
    }
}

