//
//  Router.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import UIKit

protocol Router: Presentable {

  func hideBar(isHidden: Bool)

  func present(_ module: Presentable?)
  func present(_ module: Presentable?, animated: Bool)

  func push(_ module: Presentable?)
  func push(_ module: Presentable?, hideBottomBar: Bool)
  func push(_ module: Presentable?, animated: Bool)
  func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)
  func push(_ module: Presentable?, animated: Bool, hideBottomBar: Bool, hideBar: Bool, completion: (() -> Void)?)
  func push(_ module: Presentable?, hideBar: Bool)
  func pushWithCustomTransition(transitionType: CATransitionType,
                                transitionSubtype: CATransitionSubtype,
                                _ module: Presentable?,
                                animated: Bool,
                                hideBar: Bool)

  func popModule()
  func popModule(animated: Bool)
  func popModule(animated: Bool, hideBar: Bool)

  func dismissModule()
  func dismissModule(animated: Bool, completion: (() -> Void)?)

  func setRootModule(_ module: Presentable?)
  func setRootModule(_ module: Presentable?, hideBar: Bool)

  func popToRootModule(animated: Bool)
}
