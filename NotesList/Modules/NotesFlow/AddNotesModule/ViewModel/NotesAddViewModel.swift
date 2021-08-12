//
//  NotesAddViewModel.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation

protocol NotesAddViewModel {
    func addNewNote(note: NotesDataType, completionHandler: @escaping (Result<Bool, Error>) -> Void)
    func noteAdded()
}
