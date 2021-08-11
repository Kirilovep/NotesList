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
    }
}

// MARK: - UITableviewDataSource -
extension NotesListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        setupCells(atIndexPath: indexPath)
    }
}

// MARK: - UITableViewDelegate -
extension NotesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 10
    }
}

// MARK: - Private functions -
private extension NotesListViewController {
    
    func setupUI() {
        setupTableView()
        setupAddButton()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(type: NotesTableViewCell.self)
    }
    
    func setupCells(atIndexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(withType: NotesTableViewCell.self, for: atIndexPath)
        
        return cell
    }
    
    func setupAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
    }
}

// MARK: - Private actions -
private extension NotesListViewController {

    @objc func addTapped() {
        viewModel.addButtonTapped()
    }
}
