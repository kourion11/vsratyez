//
//  LoginViewController.swift
//  NewVsratyezApp
//
//  Created by Сергей Юдин on 25.05.2022.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private lazy var usernameEmailField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Username or Email..."
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        return textField
    }()
    
    private lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "Password..."
        textField.returnKeyType = .continue
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    private lazy var telegramButton: UIButton = {
        let button = UIButton()
        button.setTitle("Our Telegram", for: .normal)
        button.setTitleColor(UIColor.secondaryLabel, for: .normal)
        return button
    }()
    
    private lazy var instagramButton: UIButton = {
        let button = UIButton()
        button.setTitle("Our Instargam", for: .normal)
        button.setTitleColor(UIColor.secondaryLabel, for: .normal)
        return button
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create an Account", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        view.addSubview(backgroundImageView)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.addTarget(
            self,
            action: #selector(didTapLoginButton),
            for: .touchUpInside
        )
        
        telegramButton.addTarget(
            self,
            action: #selector(didTapTelegramButton),
            for: .touchUpInside
        )
        
        instagramButton.addTarget(
            self,
            action: #selector(didTapInstagramButton),
            for: .touchUpInside
        )
        
        createAccountButton.addTarget(
            self,
            action: #selector(didTapCreateAccount),
            for: .touchUpInside
        )
        
        usernameEmailField.delegate = self
        passwordField.delegate = self
        
        setupViews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // assign frames
        headerView.frame = CGRect(
            x: 0,
            y: 0.0,
            width: view.width,
            height: view.height/3.0
        )
        
        usernameEmailField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 40,
            width: view.width - 50,
            height: 52.0
        )
        
        passwordField.frame = CGRect(
            x: 25,
            y: usernameEmailField.bottom + 10,
            width: view.width - 50,
            height: 52.0
        )
        
        loginButton.frame = CGRect(
            x: 25,
            y: passwordField.bottom + 10,
            width: view.width - 50,
            height: 52.0
        )
        
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 10,
            width: view.width - 50,
            height: 52.0
        )
        
        telegramButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 50,
            width: view.width - 20,
            height: 50
        )
        
        instagramButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 85,
            width: view.width - 20,
            height: 50
        )
        
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else { return }
        guard let backgroundView = headerView.subviews.first else { return }
        backgroundView.frame = headerView.bounds
        
        // Add logo
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4.0,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width/2.0,
                                 height: headerView.height - view.safeAreaInsets.top)
    }
    
    private func setupViews() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(telegramButton)
        view.addSubview(instagramButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
    }
    
    @objc
    private func didTapLoginButton() {
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else { return }
        
        var username: String?
        var email: String?
        
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            // email
            email = usernameEmail
        } else {
            //username
            username = usernameEmail
        }
        
        AuthManager.shared.loginUser(username: username, email: email, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    // user logged in
                    self.dismiss(animated: true, completion: nil)
                } else {
                    // error
                    let alert = UIAlertController(
                        title: "Log In Error",
                        message: "We were unable to log you in.",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(
                        title: "OK",
                        style: .cancel,
                        handler: nil)
                    )
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc
    private func didTapTelegramButton() {
        guard let url = URL(string: "https://t.me/zhmihnytie") else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc
    private func didTapInstagramButton() {
        guard let url = URL(string: "https://www.instagram.com/vsratyez") else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }

    @objc
    private func didTapCreateAccount() {
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapLoginButton()
        }
        return true
    }
}
