//
//  NotesListViewModel.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation

protocol NotesListViewModel {
    func addButtonTapped()
    func exitButtonTapped()
    func viewIsReady()
    func fetchNotes(completionHandler: @escaping (Result<Bool, Error>) -> Void)
    func deleteNote(at indexPath: IndexPath, completionHandler: @escaping (Result<Bool, Error>) -> Void)
    func numberOfNotes() -> Int
    func getNotes() -> [NotesViewModelType]
}
