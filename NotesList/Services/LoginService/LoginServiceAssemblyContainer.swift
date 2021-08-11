//
//  LoginServiceAssemblyContainer.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Swinject

class LoginServiceAssemblyContainer: Assembly {

    func assemble(container: Container) {
        container.register(LoginService.self) { resolver in
            let loginService = LoginServiceImp()

            return loginService
        }
    }
}
