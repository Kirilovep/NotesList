//
//  DatabaseServiceImp.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 12.08.2021.
//

import Foundation
import Firebase

class DatabaseServiceImp: DatabaseService {
    
    private var database = Firestore.firestore()
    private let auth = Auth.auth()
    private let storage = Storage.storage().reference()
    
    func addNewNote(note: NotesDataType, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        var ref: DocumentReference? = nil
        let newUUID = UUID().uuidString
        
        ref = database.collection(UserKeys.usersCollectionPath.rawValue).addDocument(data: [
            (UserKeys.userDescriptionPath.rawValue): note.description,
            UserKeys.userDatePath.rawValue: DateFormatterHelper.convertDateToString(date: note.date),
            UserKeys.userNoteId.rawValue: newUUID
        ]) { error in
            if let error = error {
                completionHandler(.failure(error))
            } else {
                guard let image = note.image else { return }
                self.uploadPhoto(image: image, imageRef: newUUID) { (result) in
                    switch result {
                    case .success(_):
                        completionHandler(.success(true))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            }
        }
    }
    
    func getNotesData(completionHandler: @escaping (Result<[NotesViewModelType], Error>) -> Void) {
        database.collection(UserKeys.usersCollectionPath.rawValue).getDocuments { (snapshot, error) in
            var notes: [NotesViewModelType] = []
            if let error = error {
                completionHandler(.failure(error))
            } else {
                snapshot!.documents.forEach { documents in
                    let data = documents.data()
                    let descriptionText = data[UserKeys.userDescriptionPath.rawValue] as? String
                    let noteDate = data[UserKeys.userDatePath.rawValue] as? String
                    let noteId = data[UserKeys.userNoteId.rawValue] as? String
                    let imageRef = self.storage.child("\(UserKeys.userImages.rawValue)/\(noteId!)")
                    notes.append(NotesViewModelType(strImageUrl: imageRef, strDate: noteDate, description: descriptionText))
                }
                completionHandler(.success(notes))
            }
        }
    }
    
    func uploadPhoto(image: UIImage, imageRef: String?, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let imageRef = imageRef else { return }

        if let uploadData = image.pngData() {
            let imageReference = storage.child(UserKeys.userImages.rawValue).child(imageRef)
            imageReference.putData(uploadData, metadata: nil) { (data, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
        }
    }
}
