//
//  RegistrationViewModel.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Firebase

protocol RegistrationViewModel {
    func registerUser(with email: String?, password: String?, completionHandler: @escaping (Result<AuthDataResult, Error>) -> Void)
    func userSuccessfullyRegistered()
    func onCancelButtonTapped()
}
