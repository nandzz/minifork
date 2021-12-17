//
//  RepositoryRestaurantFavourite.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation


class DefaultRespositoryFavourite: RepositoryFavouriteRestaurant {

  var cache: Any

  init(cache: Any) {
    self.cache = String()
  }

  func saveFavourite(restaurant: RestaurantDTO, completion: @escaping RepositoryCompletionResponse<Restaurant>) {
    fatalError()
  }

  func restoreListOfFavourite(completion: @escaping RepositoryCompletionResponse<RestaurantList>) {
    fatalError()
  }

  func removeRestaurantFromFavourite(uuid: String, completion: @escaping RepositoryCompletionResponse<Void>) {

  }
}
