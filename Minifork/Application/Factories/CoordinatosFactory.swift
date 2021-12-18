//
//  CoordinatosFactory.swift
//  Minifork
//
//  Created by Felipe Fernandes on 18/12/21.
//

import Foundation

struct CoordinatorFactory {

  func makeRestaurantListCoordinator (with navigation: WrapNavigation) -> RestaurantListCoordinator {
      let router = Router(navigationController: navigation.item)
      let coordinator = RestaurantListCoordinator(router: router, navigation: navigation.item)
      return coordinator
  }

}
