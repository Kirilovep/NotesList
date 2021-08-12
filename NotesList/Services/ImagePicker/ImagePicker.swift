//
//  ImagePicker.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 12.08.2021.
//

import UIKit

protocol ImagePickerDelegate: AnyObject {
    func didSelect(image: UIImage?)
    func presentAlert()
}

class ImagePicker: NSObject, UINavigationControllerDelegate {

    private let pickerController: UIImagePickerController
    weak var presentationController: UIViewController!
    weak var delegate: ImagePickerDelegate!

    override init() {
        pickerController = UIImagePickerController()

        super.init()

        pickerController.delegate = self
        pickerController.allowsEditing = true
    }

    func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }

        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }

    func present(from sourceView: UIView) {
        delegate?.presentAlert()
    }
}

// MARK: - Private functions -
private extension ImagePicker {

    func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)

        self.delegate?.didSelect(image: image)
    }
}

// MARK: - UIImagePicker delegates -
extension ImagePicker: UIImagePickerControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        pickerController(picker, didSelect: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }

        pickerController(picker, didSelect: image)
    }
}
