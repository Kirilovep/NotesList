//
//  NotesViewModelType.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 12.08.2021.
//

import Firebase

struct NotesViewModelType: NotesCellViewModelType {
    let strImageUrl: StorageReference
    let strDate: String?
    let description: String?
    let noteId: String?
}
