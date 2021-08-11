//
//  LoginAssemblyContainer.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Swinject

class LoginAssemblyContainer: Assembly {

    func assemble(container: Container) {
        
        container.register(LoginViewModel.self) { (resolver, output: LoginViewModelOutput) in
            let viewModel = LoginViewModelImp()
            viewModel.output = output
            viewModel.loginService = resolver.resolve(LoginService.self)
            return viewModel
        }
        
        container.register(LoginViewController.self) { (resolver, output: LoginViewModelOutput) in
            let loginController = LoginViewController.loadFromStoryboard()
            loginController.viewModel = resolver.resolve(LoginViewModel.self, argument: output)
            return loginController
        }
    }
}
