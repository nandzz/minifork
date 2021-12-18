//
//  Coordinator.swift
//  Minifork
//
//  Created by Felipe Fernandes on 18/12/21.
//

import Foundation
import UIKit


public protocol WrapNavigation {
  var item: UINavigationController { get }
}

struct DefaultNavigation : WrapNavigation {
  var item: UINavigationController
}

public protocol Coordinator: AnyObject {

  var childCoordinators: [Coordinator] { get set }

  var rootViewController: UIViewController { get }

  var router: RoutingType { get }

  func start ()
}

public extension Coordinator  {

  func addChild(_ coordinator: Coordinator) {
    childCoordinators.append(coordinator)
  }

  func removeChild (_ coordinator: Coordinator) {
    childCoordinators = childCoordinators.filter { $0 !== coordinator }
  }

  func present (_ coordinator: Coordinator, animated: Bool) {
    addChild(coordinator)
    coordinator.start()
    rootViewController.present(coordinator.rootViewController, animated: true)
  }

  func dismissCoordinator (_ coordinator: Coordinator) {
    coordinator.rootViewController.dismiss(animated: true, completion: nil)
    removeChild(coordinator)
  }

  func push (_ coordinator: Coordinator, animated: Bool) {
    addChild(coordinator)
    coordinator.start()
    router.push(coordinator.rootViewController,
                animated: animated,
                onPoppedCompletion: {[weak self] in
                  self?.removeChild(coordinator)
                })
  }

}
