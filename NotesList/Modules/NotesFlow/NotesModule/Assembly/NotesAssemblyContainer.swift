//
//  NotesAssemblyContainer.swift
//  NotesList
//
//  Created by shizo663 on 11.08.2021.
//

import Swinject
import Foundation

class NotesAssemblyContainer: Assembly {

    func assemble(container: Container) {
        container.register(NotesListViewModel.self) { (resolver, output: NotesListViewModelOutput) in
            let viewModel = NotesListViewModelImp()
            viewModel.output = output
            viewModel.notesService = resolver.resolve(NotesService.self)

            return viewModel
        }
        
        container.register(NotesListViewController.self) { (resolver, output: NotesListViewModelOutput) in
            let controller = NotesListViewController.loadFromStoryboard()
            controller.viewModel = resolver.resolve(NotesListViewModel.self, argument: output)
            
            return controller
        }
    }
}
