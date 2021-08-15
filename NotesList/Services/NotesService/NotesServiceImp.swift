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
    private enum EmptyData: Error {
        case emptyData
    }
    
    var database: DatabaseService!

    func fetchNotes(completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        database.getNotesData { (result) in
            switch result {
            case .success(let data):
                self.notes = data
                if self.notes.isEmpty {
                    completionHandler(.failure(EmptyData.emptyData))
                    return
                }
                completionHandler(.success(true))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func deleteNote(at indexPath: IndexPath, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        guard let noteId = notes[indexPath.row].noteId else { return }
        database.deleteNote(noteId: noteId) { (result) in
            switch result {
            case .success(_):
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
