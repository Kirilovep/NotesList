//
//  NotesAddViewController.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import UIKit

class NotesAddViewController: UIViewController, StoryboardLoadable {
    
    // MARK: - Properties -
    var viewModel: NotesAddViewModel!

    // MARK: - IBOutlets -
    @IBOutlet private weak var descriptionTextView: UITextView!
    private let containerView = UIView()
//    @IBOutlet private weak var containerView: UIView!
//    @IBOutlet private weak var imageButton: UIButton!
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Private functions -
private extension NotesAddViewController {
    
    func setupUI() {
        setupContainerView()
        setupImageButton()
        setupTextView()
        setupObservers()
    }
    
    func setupContainerView() {
        containerView.layer.borderWidth = 0.3
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.cornerRadius = ViewProperties.cornerRadius
        containerView.frame.size.height = 300
        containerView.frame.size.width = view.frame.width
        containerView.backgroundColor = .red
    }
    
    func setupImageButton() {
//        imageButton.setTitle("Add image".localized(), for: .normal)
    }
    
    func setupTextView() {
        descriptionTextView.becomeFirstResponder()
        descriptionTextView.textColor = .lightGray
        descriptionTextView.text = "Type your text here...".localized()
        descriptionTextView.inputAccessoryView = containerView
    }

    func setupObservers() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - Private actions -
private extension NotesAddViewController {
    
    @IBAction func addImageButtonTapped(_ sender: UIButton) {
    }
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.containerView.frame.origin.y == 0 {
//                self.containerView.frame.origin.y -= keyboardSize.height
//            }
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if self.containerView.frame.origin.y != 0 {
//            self.containerView.frame.origin.y = 0
//        }
//    }
}
