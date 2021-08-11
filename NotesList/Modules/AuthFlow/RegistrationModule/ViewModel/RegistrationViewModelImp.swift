//
//  RegistrationViewModelImp.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation
import Firebase

class RegistrationViewModelImp: RegistrationViewModel {
 
    // MARK: - Properties -
    var output: RegistrationViewModelOutput!
    var registrationService: RegistrationService!
    
    // MARK: - Functions -
    func registerUser(with email: String?, password: String?, completionHandler: @escaping (Result<AuthDataResult, Error>) -> Void) {
        registrationService.registerUser(with: email, password: password, completionHandler: completionHandler)
    }
}

//MARK: - RegistrationViewModelOutput
extension RegistrationViewModelImp {

    func userSuccessfullyRegistered() {
        output.moveToMainFlow()
    }

    func onCancelButtonTapped() {
        output.popToLoginScreen()
    }
}
