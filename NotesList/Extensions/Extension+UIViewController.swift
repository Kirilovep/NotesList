//
//  Extension+UIViewController.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import UIKit

extension UIViewController {
    func showAlertWithError(message: String, title: String = "Something went wrong...".localized()) {
        let alert = UIAlertController(title: "Something went wrong...".localized(),
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
