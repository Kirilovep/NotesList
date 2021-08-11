//
//  ValidatorServiceImp.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation

class ValidatorServiceImp: ValidatorService {
    
    // MARK:- Properties -
    private static let minimumPasswordCharacters = 6

    // MARK: - Functions -
    static func validatedPassword(_ value: String) throws -> String {
        guard value != "" else { throw ValidationError.message("Password is Required".localized()) }
        guard value.count >= minimumPasswordCharacters else { throw ValidationError.message("Password must have at least 6 characters".localized()) }

        do {
            if try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$",
                                       options: .caseInsensitive).firstMatch(in: value,
                                                                             options: [],
                                                                             range: NSRange(location: 0,
                                                                             length: value.count)) == nil {
                throw ValidationError.message("Password must be more than 6 characters, with at least one character and one numeric character".localized())
            }
        } catch {
            throw ValidationError.message("Password must be more than 6 characters, with at least one character and one numeric character".localized())
        }
        return value
    }

    static func validatedEmail(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$",
                                       options: .caseInsensitive).firstMatch(in: value,
                                                                             options: [],
                                                                             range: NSRange(location: 0,
                                                                             length: value.count)) == nil {
                throw ValidationError.message("Invalid e-mail Address".localized())
            }
        } catch {
            throw ValidationError.message("Invalid e-mail Address".localized())
        }
        return value
    }
}
