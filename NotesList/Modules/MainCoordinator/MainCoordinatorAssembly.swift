//
//  MainCoordinatorAssembly.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation
import Swinject

final class MainCoordinatorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MainCoordinator.self) { (resolver, router: Router!) in
            let coordinator = MainCoordinator()
            coordinator.resolver = resolver
            coordinator.router = router
            return coordinator
        }
    }
}
