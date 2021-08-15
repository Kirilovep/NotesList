//
//  NotesService.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 12.08.2021.
//

import Foundation

protocol NotesService {
    func fetchNotes(completionHandler: @escaping (Result<Bool, Error>) -> Void)
    func deleteNote(at indexPath: IndexPath, completionHandler: @escaping (Result<Bool, Error>) -> Void)
    func numberOfNotes() -> Int
    func getNotes() -> [NotesViewModelType]
}
