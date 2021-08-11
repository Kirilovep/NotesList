//
//  MainCoordinator.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation
import Swinject
import Firebase

final class MainCoordinator: BaseCoordinator {

    // MARK: - Properties -
    private let userDefaults = UserDefaults()

    var router: Router!
    var resolver: Resolver!

    override func start() {
        showFlow()
    }
}

// MARK: Private functions -
private extension MainCoordinator {

    func showFlow() {
        let loginScreen = createLoginScreen()
        
        if userDefaults.bool(forKey: UserKeys.userLoginStatusKey.rawValue) {
            createNotesCoordinator()
        } else {
            router.setRootModule(loginScreen, hideBar: true)
        }
    }

    func createRegistrationScreen() -> RegistrationViewController {
        guard let registrationView = resolver.resolve(RegistrationViewController.self, argument: self as RegistrationViewModelOutput) else {
            fatalError("Couln't load registration view")
        }
        
        return registrationView
    }
    
    func createLoginScreen() -> LoginViewController {
        guard let loginView = resolver.resolve(LoginViewController.self, argument: self as LoginViewModelOutput) else {
            fatalError("Couln't load login view")
        }
        
        return loginView
    }
    
    func createNotesCoordinator() {
//        guard let notesCoordinator = resolver.resolve(NotesCoordinator.self, argument: router) else {
//            return
//        }
        let notesCoordinator = resolver.resolve(NotesCoordinator.self, argument: router)!
        addDependency(notesCoordinator)
        notesCoordinator.start()
    }
}

//MARK: - RegistrationViewModelOutput
extension MainCoordinator: RegistrationViewModelOutput {

    func popToLoginScreen() {
        router.dismissModule()
    }
    
    func moveToMainFlow() {
        createNotesCoordinator()
        removeDependency(self)
    }
}

//MARK: - LoginViewModelOutput -
extension MainCoordinator: LoginViewModelOutput {

    func pushToMainFlow() {
        createNotesCoordinator()
        removeDependency(self)
    }
    
    func presentRegisterScreen() {
        let registerScreen = createRegistrationScreen()
        router.present(registerScreen)
    }
}
