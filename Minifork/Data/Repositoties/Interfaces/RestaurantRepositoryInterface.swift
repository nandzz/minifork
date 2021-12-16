//
//  RestaurantRepositoryInterface.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation


protocol RestaurantRepository {

  var service: RestaurantService { get }

  func getRestaurantList(completion: @escaping ServiceCompletion)
  func saveFavouriteRestaurant(restaurant: RestaurantDTO)
  func getFavouriteRestaurantList()

}
