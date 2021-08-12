//
//  NotesAddAssemblyContainer.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation
import Swinject

class NotesAddAssemblyContainer: Assembly {

    func assemble(container: Container) {
        container.register(NotesAddViewModel.self) { (resolver, output: NotesAddViewModelOutput) in
            let viewModel = NotesAddViewModelImp()
            viewModel.output = output
            return viewModel
        }
        
        container.register(ImagePicker.self) { (resolver, view: NotesAddViewController) in
            let imagePicker = ImagePicker()
            imagePicker.delegate = view
            imagePicker.presentationController = view
            return imagePicker
        }
        
        container.register(NotesAddViewController.self) { (resolver, output: NotesAddViewModelOutput) in
            let controller = NotesAddViewController.loadFromStoryboard()
            controller.viewModel = resolver.resolve(NotesAddViewModel.self, argument: output)
            controller.imagePicker = resolver.resolve(ImagePicker.self, argument: controller)
            controller.database = resolver.resolve(DatabaseService.self)
            return controller
        }
    }
}
