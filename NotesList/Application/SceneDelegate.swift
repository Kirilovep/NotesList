//
//  SceneDelegate.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import UIKit
import Swinject
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private let assembler = Assembler([ApplicationCoordinatorAssembly(),
                                        MainCoordinatorAssembly(),
                                        RegistrationAssemblyContainer(),
                                        RegistrationServiceAssemblyContainer(),
                                        LoginAssemblyContainer(),
                                        LoginServiceAssemblyContainer(),
                                        NotesAssemblyContainer(),
                                        NotesCoordinatorAssemblyContainer(),
                                        NotesAddAssemblyContainer(),
                                        DatabaseAssemblyContainer(),
                                        NotesServiceAssemblyConatiner()])
    private let navigationController = UINavigationController()
    private var applicationCoordinator: ApplicationCoordinator!
    private var router: Router!
 
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        setupApplicationCoordinator()
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        applicationCoordinator.start()
    }
}

// MARK: - Private functions -
extension SceneDelegate {
    
    func setupApplicationCoordinator() {
        router = RouterImp(rootController: navigationController)
        applicationCoordinator = assembler.resolver.resolve(ApplicationCoordinator.self, argument: router)!
    }
}
