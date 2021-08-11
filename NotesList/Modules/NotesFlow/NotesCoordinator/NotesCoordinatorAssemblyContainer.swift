//
//  NotesCoordinatorAssemblyContainer.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation
import Swinject

final class NotesCoordinatorAssemblyContainer: Assembly {
    func assemble(container: Container) {
        container.register(NotesCoordinator.self) { (resolver, router: Router!) in
            let coordinator = NotesCoordinator()
            coordinator.resolver = resolver
            coordinator.router = router
            return coordinator
        }
    }
}
