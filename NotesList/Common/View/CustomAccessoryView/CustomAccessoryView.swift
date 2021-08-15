//
//  CustomAccessoryView.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 12.08.2021.
//

import UIKit

class CustomAccessoryView: UIView {

    // MARK: - Properties -
    private let borderWidth: CGFloat = 0.3

    var addImageButtonTapped: (() -> Void)?

    // MARK: - IBOutlets -
    @IBOutlet private weak var addImageButton: UIButton!

    // MARK: - Lifecycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

// MARK: - Private functions -
private extension CustomAccessoryView {
    
    func setupUI() {
        layer.borderWidth = borderWidth
        layer.borderColor = UIColor.lightGray.cgColor
        addImageButton.setTitle("Add image".localized(), for: .normal)
    }
}

// MARK: - Private actions -
private extension CustomAccessoryView {

    @IBAction func onAddImageButtonTapped(_ sender: UIButton) {
        addImageButtonTapped?()
    }
}
