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
    
    func addNewNote() {
        var ref: DocumentReference? = nil
        
        ref = database.collection("users").addDocument(data: [
                                                        "first": "Ada",
                                                        "last": "Lovelace",
                                                        "born": 1815], completion: { err in
                                                            if let err = err {
                                                                print("error adding document \(err)")
                                                            } else {
                                                                print("Document added with id \(ref?.documentID)")
                                                            }
                                                        })
    }
}
