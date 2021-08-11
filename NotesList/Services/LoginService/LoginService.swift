//
//  LoginService.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation
import Firebase

protocol LoginService {
    func signIn(withEmail: String?, password: String?, completionHandler: @escaping (Result<AuthDataResult, Error>) -> Void)
}
