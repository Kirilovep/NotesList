//
//  RegistrationAssemblyContainter.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation
import Swinject

class RegistrationAssemblyContainer: Assembly {

    func assemble(container: Container) {
        container.register(RegistrationViewModel.self) { (resolver, output: RegistrationViewModelOutput) in
            let viewModel = RegistrationViewModelImp()
            viewModel.output = output
            viewModel.registrationService = resolver.resolve(RegistrationService.self)
            return viewModel
        }
        
        container.register(RegistrationViewController.self) { (resolver, output: RegistrationViewModelOutput) in
            let controller = RegistrationViewController.loadFromStoryboard()
            controller.viewModel = resolver.resolve(RegistrationViewModel.self, argument: output)
            
            return controller
        }
    }
}
