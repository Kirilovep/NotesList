//
//  DatabaseAssemblyContainer.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 12.08.2021.
//

import Foundation
import Swinject

class DatabaseAssemblyContainer: Assembly {

    func assemble(container: Container) {
        container.register(DatabaseService.self) { resolver in
            let databaseService = DatabaseServiceImp()
    
            return databaseService
        }
    }
}
