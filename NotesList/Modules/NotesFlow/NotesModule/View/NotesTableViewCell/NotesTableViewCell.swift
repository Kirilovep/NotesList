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
    private let containterborderWidth: CGFloat = 0.3
    private let containerCornerRadius: CGFloat = 20
    private let imageCornerRadius: CGFloat = 10
    
    var viewModel: NotesCellViewModelType? {
        didSet {
            activityIndicator.startAnimating()
            guard let viewModel = viewModel else {
                activityIndicator.stopAnimating()
                return
            }
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
        containerView.layer.borderWidth = containterborderWidth
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.cornerRadius = containerCornerRadius
        noteImageView.layer.cornerRadius = imageCornerRadius
        setupActivityIndicator()
    }
    
    func setupActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
    }
}
