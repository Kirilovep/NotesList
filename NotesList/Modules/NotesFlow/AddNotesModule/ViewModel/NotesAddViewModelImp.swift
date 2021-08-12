//
//  NotesAddViewModelImp.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation

class NotesAddViewModelImp: NotesAddViewModel {
  
    // MARK: - Properties -
    var output: NotesAddViewModelOutput!
    var database: DatabaseService!
    
    func addNewNote(note: NotesDataType, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        database.addNewNote(note: note, completionHandler: completionHandler)
    }
    
    func noteAdded() {
        output.popScreen()
    }
}
