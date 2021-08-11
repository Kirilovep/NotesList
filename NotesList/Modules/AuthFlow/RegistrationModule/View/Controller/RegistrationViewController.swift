//
//  RegistrationViewController.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import UIKit

class RegistrationViewController: UIViewController, StoryboardLoadable {

    // MARK: - Properties -
    var viewModel: RegistrationViewModel!

    // MARK: - IBOutlets -
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var registrationButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - UITextField delegate -
extension RegistrationViewController: UITextFieldDelegate {
    
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
private extension RegistrationViewController {

    func setupUI() {
        setupLabels()
        setupTextFields()
        setupButton()
        setupActivityIndicator()
    }

    func setupLabels() {
        emailLabel.text = "Email".localized()
        passwordLabel.text = "Password".localized()
    }

    func setupButton() {
        registrationButton.setTitle("Register".localized(), for: .normal)
        registrationButton.backgroundColor = .systemBlue
        registrationButton.layer.cornerRadius = ButtonProperties.cornerRadius
        registrationButton.tintColor = .white
    }

    func setupTextFields() {
        emailTextField.placeholder = "Start typing your email".localized()
        passwordTextField.placeholder = "Start typing your password".localized()
//        passwordTextField.isSecureTextEntry = true

        emailTextField.delegate = self
        passwordTextField.delegate = self
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

// MARK: - Private actions -
private extension RegistrationViewController {

    @IBAction func onRegistrationButtonTapped(_ sender: UIButton) {
        activityIndicator.startAnimating()
        guard let validatedData = validate() else { return }
        
        viewModel.registerUser(with: validatedData.email, password: validatedData.password) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(_):
                self.activityIndicator.stopAnimating()
                self.viewModel.userSuccessfullyRegistered()
            case .failure(let error):
                self.showAlertWithError(message: error.localizedDescription)
                self.activityIndicator.stopAnimating()
            }
        }
    }

    @IBAction func onCancelButtonTapped(_ sender: UIButton) {
        viewModel.onCancelButtonTapped()
    }
}
