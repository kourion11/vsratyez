//
//  LoginViewController.swift
//  NewVsratyezApp
//
//  Created by Сергей Юдин on 25.05.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    private lazy var usernameEmailField: UITextField = {
       let textField = UITextField()
        return textField
    }()
    
    private lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var termsButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var privacyButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // assign frames
        
    }
    
    private func setupViews() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
    }
    
    @objc
    private func didTapLoginButton() {
        
    }
    
    @objc
    private func didTapTermsButton() {
        
    }
    
    @objc
    private func didTapPrivacyButton() {
        
    }

    @objc
    private func didTapCreateAccount() {
        
    }
}
