//
//  ApplicationCoordinatorAssembly.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation
import Swinject

final class ApplicationCoordinatorAssembly: Swinject.Assembly {
    func assemble(container: Container) {
        container.register(ApplicationCoordinator.self) { (resolver, router: Router!) in
            let appCoordinator = ApplicationCoordinator()
            appCoordinator.router = router
            appCoordinator.resolver = resolver
            return appCoordinator
        }
    }
}
