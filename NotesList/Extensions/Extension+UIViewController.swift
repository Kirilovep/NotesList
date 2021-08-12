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
    
    func createCustomAccessoryView() -> CustomAccessoryView {
        guard let customView = Bundle.main.loadNibNamed("CustomAccessoryView",
                                                        owner: self,
                                                        options: nil)?.first as? CustomAccessoryView else {
            fatalError("Failed load xib")
        }

        customView.frame.size.height = 50

        return customView
    }
    
    func showAlertForImagePicker(imagePicker: ImagePicker) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let action = imagePicker.action(for: .camera, title: "Take photo".localized()) {
            alertController.addAction(action)
        }
        if let action = imagePicker.action(for: .savedPhotosAlbum, title: "Camera roll".localized()) {
            alertController.addAction(action)
        }
        if let action = imagePicker.action(for: .photoLibrary, title: "Photo library".localized()) {
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil))

        self.present(alertController, animated: true)
    }
}
