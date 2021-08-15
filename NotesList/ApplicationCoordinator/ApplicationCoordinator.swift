//
//  ApplicationCoordinator.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation
import Swinject

final class ApplicationCoordinator: BaseCoordinator {

    var router: Router!
    var resolver: Resolver!

    override func start() {
        showMainCoordinator()
    }
}

private extension ApplicationCoordinator {

    func showMainCoordinator() {
        guard let mainCoordinator = resolver.resolve(MainCoordinator.self, argument: router) else { return }
        addDependency(mainCoordinator)
        mainCoordinator.start()
    }
}
