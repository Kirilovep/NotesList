//
//  NoteServiceAssemblyConatiner.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 12.08.2021.
//

import Swinject

class NotesServiceAssemblyConatiner: Assembly {

    func assemble(container: Container) {
        container.register(NotesService.self) { resolver in
            let notesService = NotesServiceImp()
            notesService.database = resolver.resolve(DatabaseService.self)

            return notesService
        }.inObjectScope(.container)
    }
}
