//
//  Router.swift
//  Minifork
//
//  Created by Felipe Fernandes on 18/12/21.
//

import Foundation
import UIKit


public protocol RoutingType {

  func popToRootViewController(animated: Bool)

  func popToViewController(_ viewController: UIViewController, animated: Bool)

  func popViewController(animated: Bool)

  func push(_ viewController: UIViewController, animated: Bool, onPoppedCompletion: (() -> Void)?)

  func setRootViewController(_ viewController: UIViewController, animated: Bool)

}

public extension RoutingType {

  func push(_ viewController: UIViewController, animated: Bool) {
    push(viewController, animated: animated, onPoppedCompletion: nil)
  }

}

public final class Router: NSObject, RoutingType {

  private weak var navigationController: UINavigationController?
  private var completions: [UIViewController: () -> Void]

  public init(navigationController: UINavigationController = UINavigationController()) {
    self.navigationController = navigationController
    self.completions = [:]
    super.init()
    self.navigationController?.delegate = self
  }

}

public extension Router {

  func popToRootViewController(animated: Bool)  {
    if let poppedControllers = navigationController?.popToRootViewController(animated: animated) {
      poppedControllers.forEach { runCompletion(for: $0) }
    }
  }

  func popToViewController(_ viewController: UIViewController, animated: Bool) {
    if let poppedControllers = navigationController?.popToViewController(viewController, animated: animated) {
      poppedControllers.forEach { runCompletion(for: $0) }
    }
  }

  func popViewController(animated: Bool) {
    if let poppedController = navigationController?.popViewController(animated: animated) {
      runCompletion(for: poppedController)
    }
  }

  func push(_ viewController: UIViewController, animated: Bool, onPoppedCompletion: (() -> Void)? = nil) {
    if let completion = onPoppedCompletion {
      completions[viewController] = completion
    }

    navigationController?.pushViewController(viewController, animated: animated)
  }

  func setRootViewController(_ viewController: UIViewController, animated: Bool) {
    completions.forEach { $0.value() }
    completions = [:]
    navigationController?.setViewControllers([viewController], animated: animated)
  }

}

extension Router: UINavigationControllerDelegate {

  public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    guard let poppingViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
          !navigationController.viewControllers.contains(poppingViewController) else {
      return
    }
    runCompletion(for: poppingViewController)
  }

}

private extension Router {

  func runCompletion(for controller: UIViewController) {
    guard let completion = completions[controller] else { return }
    completion()
    completions.removeValue(forKey: controller)
  }
}
