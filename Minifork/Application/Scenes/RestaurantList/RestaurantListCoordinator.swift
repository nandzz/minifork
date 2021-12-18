//
//  RestaurantListCoordinator.swift
//  Minifork
//
//  Created by Felipe Fernandes on 18/12/21.
//

import Foundation
import UIKit



class RestaurantListCoordinator: Coordinator {

  var childCoordinators: [Coordinator] = []
  var rootViewController: UIViewController
  var router: RoutingType

  init(router: RoutingType, navigation: UINavigationController) {
    self.router = router
    self.rootViewController = navigation
  }

  func start() {
    let controller = RestaurantListViewController()
    router.setRootViewController(controller, animated: true)
  }
}
