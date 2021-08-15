//
//  CustomEmptyDataView.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 15.08.2021.
//

import UIKit

class CustomEmptyDataView: UIView {
    
    // MARK: - IBOutlets -
    @IBOutlet private weak var pullToRefreshLabel: UILabel!
    @IBOutlet private weak var addNewNoteLabel: UILabel!
    
    // MARK: - Lifecycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

// MARK: - Private functions -
private extension CustomEmptyDataView {
    
    func setupUI() {
        pullToRefreshLabel.text = "Pull to refresh".localized()
        addNewNoteLabel.text = "or add a new note".localized()
    }
}
