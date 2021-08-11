//
//  LoginViewModelImp.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation
import Firebase

class LoginViewModelImp: LoginViewModel {

    // MARK: - Properties -
    var output: LoginViewModelOutput!
    var loginService: LoginService!

    // MARK: - Functions -
    func signIn(withEmail: String?, password: String?, completionHandler: @escaping (Result<AuthDataResult, Error>) -> Void) {
        loginService.signIn(withEmail: withEmail, password: password, completionHandler: completionHandler)
    }
}

// MARK: - LoginViewModelOutput -
extension LoginViewModelImp {

    func onRegisterButtonTapped() {
        output.presentRegisterScreen()
    }

    func userSuccessfullyLogin() {
        output.pushToMainFlow()
    }
}
