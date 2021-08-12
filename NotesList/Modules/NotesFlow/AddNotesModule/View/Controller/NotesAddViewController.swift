//
//  NotesAddViewController.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import UIKit

class NotesAddViewController: UIViewController, StoryboardLoadable {
    
    // MARK: - Properties -
    private var pickedImage: UIImage?

    var viewModel: NotesAddViewModel!
    var imagePicker: ImagePicker!
    var database: DatabaseService!
    
    // MARK: - IBOutlets -
    @IBOutlet private weak var descriptionTextView: UITextView!

    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        database.addNewNote()
    }
}

// MARK: - UITextViewDelegate -
extension NotesAddViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTextView.textColor == .lightGray {
            descriptionTextView.text = nil
            descriptionTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text.isEmpty || descriptionTextView.text == "" {
            descriptionTextView.textColor = .lightGray
            descriptionTextView.text = "Type your text here...".localized()
        }
    }
}

// MARK: - ImagePickerDelegate
extension NotesAddViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        pickedImage = image
    }
    
    func presentAlert() {
        showAlertForImagePicker(imagePicker: imagePicker)
    }
}

// MARK: - Private functions -
private extension NotesAddViewController {
    
    func setupUI() {
        setupSaveButton()
        setupTextView()
    }

    func setupTextView() {
        descriptionTextView.becomeFirstResponder()
        descriptionTextView.textColor = .lightGray
        descriptionTextView.text = "Type your text here...".localized()
        descriptionTextView.delegate = self
        let customAccessoryView = createCustomAccessoryView()
        descriptionTextView.inputAccessoryView = customAccessoryView
        customAccessoryView.addImageButtonTapped = {
            self.presentAlert()
        }
    }

    func setupSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save".localized(), style: .plain, target: self, action: #selector(saveButtonTapped))
    }
}

// MARK: - Private actions -
private extension NotesAddViewController {
    
    @objc func saveButtonTapped() {
        
    }
}
