//
//  ValidatorService.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation

protocol ValidatorService {
    static func validatedPassword(_ value: String) throws -> String
    static func validatedEmail(_ value: String) throws -> String
}
