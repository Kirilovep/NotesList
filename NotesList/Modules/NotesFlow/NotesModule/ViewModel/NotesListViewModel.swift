//
//  NotesListViewModel.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation

protocol NotesListViewModel {
    func addButtonTapped()
    func viewIsReady()
    func fetchNotes(completionHandler: @escaping (Result<Bool, Error>) -> Void)
    func numberOfNotes() -> Int
    func getNotes() -> [NotesViewModelType]
}
