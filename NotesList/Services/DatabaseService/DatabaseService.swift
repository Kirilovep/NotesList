//
//  DatabaseService.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 12.08.2021.
//

import Foundation

protocol DatabaseService {
    func addNewNote(note: NotesDataType, completionHandler: @escaping (Result<Bool, Error>) -> Void)
    func getNotesData(completionHandler: @escaping (Result<[NotesViewModelType], Error>) -> Void)
    func deleteNote(noteId: String, completionHandler: @escaping (Result<Bool, Error>) -> Void)
}
