//
//  StoryboardLoadable.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import UIKit

protocol StoryboardLoadable: AnyObject {
    static func loadFromStoryboard() -> Self
}

extension NSObject {
    static func getClassName() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension StoryboardLoadable where Self: UIViewController {
    static func loadFromStoryboard() -> Self {
        let identifier = Self.getClassName()
        let storyboard = UIStoryboard(name: identifier, bundle: nil)

        guard let controller = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Error: Unable to load \(identifier) from storyboard")
        }

        return controller
    }
}
