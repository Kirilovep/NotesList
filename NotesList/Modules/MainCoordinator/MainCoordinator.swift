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
        let registrationScreen = createRegistrationScreen()
        
        router.setRootModule(registrationScreen, hideBar: true)
    }

    func createRegistrationScreen() -> RegistrationViewController {
        guard let registrationView = resolver.resolve(RegistrationViewController.self, argument: self as RegistrationViewModelOutput) else {
            fatalError("Couln't load registration view")
        }
        
        return registrationView
    }
}

//MARK: - RegistrationViewModelOutput
extension MainCoordinator: RegistrationViewModelOutput {

    func moveToMainFlow() {
        print("successfully")
    }
}
