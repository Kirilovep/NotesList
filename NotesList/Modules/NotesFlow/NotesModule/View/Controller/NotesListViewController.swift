//
//  NotesListViewController.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import UIKit
import Firebase

class NotesListViewController: UIViewController, StoryboardLoadable {

    // MARK: - Properties -
    private let activityIndicator = UIActivityIndicatorView()
    private let refreshControl = UIRefreshControl()
    private var customEmptyView: CustomEmptyDataView!

    var viewModel: NotesListViewModel!
    
    // MARK: - IBOutlets -
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewIsReady()
        getNotes()
    }
}

// MARK: - UITableviewDataSource -
extension NotesListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfNotes()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        setupCells(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteRow(at: indexPath)
        }
    }
}

// MARK: - UITableViewDelegate -
extension NotesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Private functions -
private extension NotesListViewController {

    func setupUI() {
        setupActivityIndicator()
        setupTableView()
        createEmptyCustomView()
        setupNavigationBarButtons()
        setupRefreshControl()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(type: NotesTableViewCell.self)
        tableView.addSubview(activityIndicator)
        tableView.backgroundView = activityIndicator
    }
    
    func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
    }
    
    func setupCells(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(withType: NotesTableViewCell.self, for: indexPath)
        
        cell.viewModel = viewModel.getNotes()[indexPath.row]

        return cell
    }
    
    func deleteRow(at indexPath: IndexPath) {
        viewModel.deleteNote(at: indexPath) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.getNotes()
            case .failure(let error):
                self?.showAlertWithError(message: error.localizedDescription)
            }
        }
    }
    
    func setupNavigationBarButtons() {
        let addButtonBarItem = UIBarButtonItem(title: "Add".localized(), style: .plain, target: self, action: #selector(addTapped))
        let exitButtonBarItem = UIBarButtonItem(title: "Exit".localized(), style: .plain, target: self, action: #selector(exitTapped))
        navigationItem.rightBarButtonItems = [addButtonBarItem, exitButtonBarItem]
    }
    
    func getNotes() {
        activityIndicator.startAnimating()
        viewModel.fetchNotes { [weak self] result in
            switch result {
            case .success(_):
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
                self?.refreshControl.endRefreshing()
                self?.customEmptyView?.isHidden = true
            case .failure(_):
                self?.activityIndicator.stopAnimating()
                self?.refreshControl.endRefreshing()
                self?.customEmptyView.isHidden = false
                self?.tableView.reloadData()
            }
        }
    }
    
    func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh".localized())
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func createEmptyCustomView() {
        guard let customView = Bundle.main.loadNibNamed("CustomEmptyDataView",
                                                        owner: self,
                                                        options: nil)?.first as? CustomEmptyDataView else {
            fatalError("Failed load xib")
        }

        customEmptyView = customView
        customEmptyView?.center = tableView.center
        tableView.addSubview(customEmptyView!)
        tableView.backgroundView = customEmptyView
    }
}

// MARK: - Private actions -
private extension NotesListViewController {

    @objc func addTapped() {
        viewModel.addButtonTapped()
    }
    
    @objc func exitTapped() {
        viewModel.exitButtonTapped()
    }
    
    @objc func refreshData() {
        getNotes()
    }
}
