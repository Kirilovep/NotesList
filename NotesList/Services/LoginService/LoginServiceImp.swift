//
//  LoginServiceImp.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation
import Firebase

class LoginServiceImp: LoginService {

    // MARK: - Properties -
    private let auth = Auth.auth()

    // MARK: - Functions -
    func signIn(withEmail: String?, password: String?, completionHandler: @escaping (Result<AuthDataResult, Error>) -> Void) {
        guard let userEmail = withEmail, let userPassword = password else { return }

        auth.signIn(withEmail: userEmail, password: userPassword) { result, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            if let data = result {
                completionHandler(.success(data))
                UserDefaultsHelper.saveLoginStatus(login: true)
            }
        }
    }
}
