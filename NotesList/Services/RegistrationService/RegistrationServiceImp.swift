//
//  RegistrationServiceImp.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation
import Firebase

class RegistrationServiceImp: RegistrationService {
    
    // MARK: - Properties -
    private let auth = Auth.auth()
    
    // MARK: - Functions -
    func registerUser(with email: String?, password: String?, completionHandler: @escaping (Result<AuthDataResult, Error>) -> Void) {
        guard let userEmail = email, let userPassword = password else { return }

        auth.createUser(withEmail: userEmail, password: userPassword) { authData, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            if let data = authData {
                completionHandler(.success(data))
            }
        }
    }
}
