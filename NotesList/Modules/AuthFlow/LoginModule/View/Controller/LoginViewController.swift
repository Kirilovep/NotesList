//
//  LoginViewController.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import UIKit

class LoginViewController: UIViewController, StoryboardLoadable {

    // MARK: - Properties -
    var viewModel: LoginViewModel!

    // MARK: - IBOutlets -
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var registrationButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - UITextField delegate -
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
}

// MARK: - Private functions -
private extension LoginViewController {
    
    func setupUI() {
        setupLabels()
        setupButtons()
        setupTextFields()
        setupActivityIndicator()
    }
    
    func setupLabels() {
        emailLabel.text = "Email".localized()
        passwordLabel.text = "Password".localized()
    }
    
    func setupTextFields() {
        emailTextField.placeholder = "Start typing your email".localized()
        passwordTextField.placeholder = "Start typing your password".localized()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func setupButtons() {
        loginButton.setTitle("Login".localized(), for: .normal)
        registrationButton.setTitle("Register".localized(), for: .normal)
        
        loginButton.backgroundColor = .systemRed
        loginButton.layer.cornerRadius = ButtonProperties.cornerRadius
        loginButton.tintColor = .white
        
        registrationButton.backgroundColor = .systemBlue
        registrationButton.layer.cornerRadius = ButtonProperties.cornerRadius
        registrationButton.tintColor = .white
    }
    
    func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
    }
    
    func validate() -> UserRegistrationData? {
        do {
            let email = try emailTextField.validatedText(validationType: ValidatorType.email)
            let password = try passwordTextField.validatedText(validationType: ValidatorType.password)

            let registrationData = UserRegistrationData(email: email, password: password)

            return registrationData
        } catch let error {
            showAlertWithError(message: "\(error)")
            activityIndicator.stopAnimating()
            return nil
        }
    }
}

// MARK: - IBActions -
private extension LoginViewController {

    @IBAction func onLoginButtonTapped(_ sender: UIButton) {
        activityIndicator.startAnimating()
        
        guard let validatedData = validate() else { return }
        
        viewModel.signIn(withEmail: validatedData.email, password: validatedData.password) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(_):
                self.viewModel.userSuccessfullyLogin()
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                self.activityIndicator.stopAnimating()
                self.showAlertWithError(message: error.localizedDescription)
            }
        }
    }

    @IBAction func onRegisterButtonTapped(_ sender: UIButton) {
        viewModel.onRegisterButtonTapped()
    }
}
