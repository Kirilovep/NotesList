//
//  NotesServiceImp.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 12.08.2021.
//

import Foundation

class NotesServiceImp: NotesService {

    // MARK: - Properties -
    private var notes: [NotesViewModelType] = []
    
    var database: DatabaseService!

    func fetchNotes(completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        database.getNotesData { (result) in
            switch result {
            case .success(let data):
                self.notes = data
                completionHandler(.success(true))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func numberOfNotes() -> Int {
        return notes.count
    }

    func getNotes() -> [NotesViewModelType] {
        return notes
    }
}
