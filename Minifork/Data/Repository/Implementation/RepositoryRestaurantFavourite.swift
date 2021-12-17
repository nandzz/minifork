//
//  RepositoryRestaurantFavourite.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation


class DefaultRespositoryFavourite: RepositoryFavouriteRestaurant {

  var storage: DefaultStorageRestaurantFavourite

  init(storage: DefaultStorageRestaurantFavourite) {
    self.storage = storage
  }

  func saveFavourite(restaurant: RestaurantDTO, completion: @escaping RepositoryCompletionResponse<Restaurant>) {
    storage.saveFavouriteRestaurant(restautant: restaurant) {
      switch $0 {
      case .success(let restaurant):
        completion(.success(restaurant.toDomain()))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func restoreListOfFavourite(completion: @escaping RepositoryCompletionResponse<RestaurantList>) {
    storage.getFavouriteRestaurantList {
      switch $0 {
      case .success(let list):
        completion(.success(RestaurantList(list: list.map({$0.toDomain()}))))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func removeRestaurantFromFavourite(uuid: String, completion: @escaping RepositoryCompletionResponse<Void>) {
    storage.removeFavouriteRestaurant(uuid: uuid, completion: completion)
  }
}
