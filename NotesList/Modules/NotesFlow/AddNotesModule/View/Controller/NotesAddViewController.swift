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
    private var descriptionText: String?

    var viewModel: NotesAddViewModel!
    var imagePicker: ImagePicker!
    
    // MARK: - IBOutlets -
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
    
    func textViewDidChange(_ textView: UITextView) {
        descriptionText = textView.text
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
        setupActivityIndicator()
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
    
    func setupActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
    }
    
    func createNote() -> NotesDataType? {
        return NotesDataType(image: pickedImage ?? UIImage(named: "defaultNoteImage"), description: descriptionText ?? "Note", date: Date())
    }
}

// MARK: - Private actions -
private extension NotesAddViewController {
    
    @objc func saveButtonTapped() {
        activityIndicator.startAnimating()
        guard let note = createNote() else {
            activityIndicator.stopAnimating()
            return
        }

        viewModel.addNewNote(note: note) { [weak self] result in
            switch result {
            case .success(_):
                self?.activityIndicator.stopAnimating()
                self?.viewModel.noteAdded()
            case .failure(let error):
                self?.showAlertWithError(message: error.localizedDescription)
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}
