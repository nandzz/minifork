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
    controller.viewModel = ViewModelFactory().createRestaurantListViewModel()
    controller.coordinator = self
    router.setRootViewController(controller, animated: true)
  }

  func presentShare (text: String) {
    print("Opening sharing")
    let textToShare = [ text ]
    let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = rootViewController.view // so that iPads won't crash
    rootViewController.present(activityViewController, animated: true, completion: nil)
  }
}
