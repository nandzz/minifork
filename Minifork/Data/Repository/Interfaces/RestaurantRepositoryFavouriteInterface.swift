//
//  RestaurantRepositoryFavouriteInterface.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation


protocol RepositoryFavouriteRestaurant {

  var storage: DefaultStorageRestaurantFavourite { get }

  func saveFavourite(restaurant: RestaurantDTO, completion: @escaping RepositoryCompletionResponse<Restaurant>)
  func restoreListOfFavourite( completion: @escaping RepositoryCompletionResponse<RestaurantList>)
  func removeRestaurantFromFavourite(uuid: String, completion: @escaping RepositoryCompletionResponse<Void>)
  
}
