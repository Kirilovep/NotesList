//
//  NotesCoordinator.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation
import Swinject

final class NotesCoordinator: BaseCoordinator {

    // MARK: - Properties -
    private let userDefaults = UserDefaults()

    var router: Router!
    var resolver: Resolver!

    override func start() {
        showNotesFlow()
    }
}

// MARK: - Private functions -
private extension NotesCoordinator {
    
    func showNotesFlow() {
        let notesView = createNotesView()
        router.setRootModule(notesView, hideBar: false)
    }
    
    func createNotesView() -> NotesListViewController {
        guard let notesView = resolver.resolve(NotesListViewController.self, argument: self as NotesListViewModelOutput) else {
            fatalError("Couldn't create notesView")
        }
        
        notesView.title = "Notes list"
        
        return notesView
    }
    
    func createAddNotesView() -> NotesAddViewController {
        guard let addNotesView = resolver.resolve(NotesAddViewController.self, argument: self as NotesAddViewModelOutput) else {
            fatalError("Couldn't create addNotesView")
        }
        
        return addNotesView
    }
}

// MARK: - NotesListViewModelOutput
extension NotesCoordinator: NotesListViewModelOutput {

    func showView() {
        router.isPrefersLargeTitlesHidden(hidden: false)
    }
    
    func onAddButtonTapped() {
        let addNotesView = createAddNotesView()

        router.push(addNotesView, hideBar: true)
    }
}

// MARK: - NotesAddViewModelOutput
extension NotesCoordinator: NotesAddViewModelOutput {

    func popScreen() {
        router.popModule()
    }
}
