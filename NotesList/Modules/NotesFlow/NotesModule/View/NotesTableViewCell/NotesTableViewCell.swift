//
//  NotesTableViewCell.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import UIKit
import FirebaseUI

class NotesTableViewCell: UITableViewCell {
    
    // MARK: - Properties -
    var viewModel: NotesCellViewModelType? {
        didSet {
            guard let viewModel = viewModel else { return }
            activityIndicator.startAnimating()
            titleLabel.text = viewModel.description
            dateLabel.text = viewModel.strDate
            noteImageView.sd_setImage(with: viewModel.strImageUrl, placeholderImage: nil) { (_, _, _, _) in
                self.activityIndicator.stopAnimating()
            }
        }
    }

    // MARK: - IBOutlets -
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var noteImageView: UIImageView!
    
    
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
        noteImageView.layer.cornerRadius = 10
        setupActivityIndicator()
    }
    
    func setupActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
    }
}
