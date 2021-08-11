//
//  NotesTableViewCell.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    // MARK: - Properties -
    var viewModel: NotesCellViewModelType? {
        didSet {
            titleLabel.text = viewModel?.description
        }
    }

    // MARK: - IBOutlets -
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    // MARK: - Lifecycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

// MARK: - Private functions -
private extension NotesTableViewCell {
    
    func setupUI() {
        contentView.backgroundColor = .clear
        containerView.layer.borderWidth = 0.3
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.cornerRadius = 20
    }
}
