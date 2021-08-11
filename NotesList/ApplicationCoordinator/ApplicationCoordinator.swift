//
//  ApplicationCoordinator.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation
import Swinject

final class ApplicationCoordinator: BaseCoordinator {

    private let router: Router
    private let resolver: Resolver

    var mainCoordinator: MainCoordinator?

    init(router: Router, resolver: Resolver) {
        self.router = router
        self.resolver = resolver
    }

    override func start() {
        showMainFlow()
    }
}

private extension ApplicationCoordinator {

    func showMainFlow() {
        mainCoordinator = resolver.resolve(MainCoordinator.self, argument: router)
        guard let coordinator = mainCoordinator else { return }
        addDependency(coordinator)
        coordinator.start()
    }
}
