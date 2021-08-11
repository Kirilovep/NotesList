//
//  RouterImp.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import UIKit

final class RouterImp: NSObject, Router {

    private weak var rootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]

    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }

    func hideBar(isHidden: Bool) {
        rootController?.isNavigationBarHidden = isHidden
    }

    func toPresent() -> UIViewController? {
        return rootController
    }

    func present(_ module: Presentable?) {
        present(module, animated: true)
    }

    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }

        rootController?.present(controller, animated: animated, completion: nil)
    }

    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }

    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }

    func push(_ module: Presentable?) {
        push(module, animated: true)
    }

    func push(_ module: Presentable?, hideBottomBar: Bool) {
        push(module, animated: true, hideBottomBar: hideBottomBar, hideBar: false, completion: nil)
    }

    func push(_ module: Presentable?, animated: Bool) {
        push(module, animated: animated, completion: nil)
    }

    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        push(module, animated: animated, hideBottomBar: false, hideBar: false, completion: completion)
    }

    func push(_ module: Presentable?, hideBar: Bool) {
        push(module, animated: true, hideBottomBar: false, hideBar: hideBar, completion: nil)
    }

    func push(_ module: Presentable?, animated: Bool, hideBottomBar: Bool, hideBar: Bool, completion: (() -> Void)?) {
        guard
            let controller = module?.toPresent(),
            (controller is UINavigationController == false)
        else { assertionFailure("Deprecated push UINavigationController."); return }

        if let completion = completion {
            completions[controller] = completion
        }

        rootController?.isNavigationBarHidden = hideBar
        rootController?.pushViewController(controller, animated: animated)
    }

    func pushWithCustomTransition(transitionType: CATransitionType,
                                  transitionSubtype: CATransitionSubtype,
                                  _ module: Presentable?,
                                  animated: Bool,
                                  hideBar: Bool) {
        guard
            let controller = module?.toPresent(),
            (controller is UINavigationController == false)
        else { assertionFailure("Deprecated push UINavigationController."); return }

        let transition = CATransition()
        transition.duration = 1.5
        transition.type = transitionType
        transition.subtype = transitionSubtype
        rootController?.view.layer.add(transition, forKey: kCATransition)
        rootController?.isNavigationBarHidden = hideBar
        controller.view.alpha = 0.1

        UIView.animate(withDuration: 1.5) {
            self.rootController?.pushViewController(controller, animated: animated)
            controller.view.alpha = 1
        }
    }

    func popModule() {
        popModule(animated: true)
    }

    func popModule(animated: Bool) {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }

    func popModule(animated: Bool, hideBar: Bool) {
        if let controller = rootController?.popViewController(animated: animated) {
            rootController?.isNavigationBarHidden = hideBar
            runCompletion(for: controller)
        }
    }

    func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false)
    }

    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.navigationBar.prefersLargeTitles = true
        rootController?.isNavigationBarHidden = hideBar
    }

    func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }

    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}
