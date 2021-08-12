//
//  CustomAccessoryView.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 12.08.2021.
//

import UIKit

class CustomAccessoryView: UIView {

    // MARK: - Properties -
    var addImageButtonTapped: (() -> Void)?

    // MARK: - Lifecycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

// MARK: - Private functions -
private extension CustomAccessoryView {
    
    func setupUI() {
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.lightGray.cgColor
    }
}

// MARK: - Private actions -
private extension CustomAccessoryView {

    @IBAction func onAddImageButtonTapped(_ sender: UIButton) {
        addImageButtonTapped?()
    }
}
