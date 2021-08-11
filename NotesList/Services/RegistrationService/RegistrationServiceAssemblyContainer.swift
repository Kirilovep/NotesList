//
//  RegistrationAssemblyContainer.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Swinject

class RegistrationServiceAssemblyContainer: Assembly {

    func assemble(container: Container) {
        container.register(RegistrationService.self) { resolver in
            let registrationService = RegistrationServiceImp()
            
            return registrationService
        }
    }
}
