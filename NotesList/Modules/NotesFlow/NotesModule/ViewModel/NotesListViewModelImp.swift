//
//  NotesListViewModelImp.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation

class NotesListViewModelImp: NotesListViewModel {

    // MARK: - Properties -
    var output: NotesListViewModelOutput!
    var notesService: NotesService!
}

// MARK: - NotesListViewModelOutput -
extension NotesListViewModelImp {

    func addButtonTapped() {
        output.onAddButtonTapped()
    }
    
    func viewIsReady() {
        output.showView()
    }

    func fetchNotes(completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        notesService.fetchNotes(completionHandler: completionHandler)
    }

    func numberOfNotes() -> Int {
        notesService.numberOfNotes()
    }
    
    func getNotes() -> [NotesViewModelType] {
        notesService.getNotes()
    }
}
