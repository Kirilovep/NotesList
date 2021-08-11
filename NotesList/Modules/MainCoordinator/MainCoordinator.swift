//
//  MainCoordinator.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation
import Swinject

final class MainCoordinator: BaseCoordinator {

    var router: Router!
    var resolver: Resolver!
    var categoriesRouter: Router?

    override func start() {
        showMainFlow()
    }
}

// MARK: Private functions -
private extension MainCoordinator {

    func showMainFlow() {
    }
}
