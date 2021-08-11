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
}

// MARK: - NotesListViewModelOutput
extension NotesCoordinator: NotesListViewModelOutput {
    
}
