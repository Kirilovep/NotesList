//
//  RegistrationService.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation
import Firebase

protocol RegistrationService {
    func registerUser(with email: String?, password: String?, completionHandler: @escaping (Result<AuthDataResult, Error>) -> Void)
}
