//
//  Extension+UITextField.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import UIKit

extension UITextField {
    func validatedText(validationType: ValidatorType) throws -> String {
        guard let text = text else {
            throw ValidationError.message("text is empty".localized())
        }

        switch validationType {
        case .email:
            return try ValidatorServiceImp.validatedEmail(text)
        case .password:
            return try ValidatorServiceImp.validatedPassword(text)
        }
    }
}
