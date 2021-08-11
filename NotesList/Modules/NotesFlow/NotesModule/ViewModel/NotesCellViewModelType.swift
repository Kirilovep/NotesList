//
//  NotesCellViewModelType.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import UIKit

protocol NotesCellViewModelType {
    var description: String { get }
    var data: Date { get }
    var image: UIImage { get }
}
