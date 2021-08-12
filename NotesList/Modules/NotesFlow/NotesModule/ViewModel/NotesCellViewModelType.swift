//
//  NotesCellViewModelType.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import UIKit
import Firebase

protocol NotesCellViewModelType {
    var description: String? { get }
    var strDate: String? { get }
    var strImageUrl: StorageReference { get }
}
