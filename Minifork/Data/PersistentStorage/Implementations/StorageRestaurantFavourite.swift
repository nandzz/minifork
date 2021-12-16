//
//  StorageRestaurantFavourite.swift
//  Minifork
//
//  Created by Felipe Fernandes on 17/12/21.
//

import Foundation

class DefaultStorageRestaurantFavourite {


  private let localStorage: LocalDataStorage

  init(localStorage: LocalDataStorage = LocalDataStorage.shared) {
    self.localStorage = localStorage
  }

  let fetchRestaurantsRequest() -> 


}

extension DefaultStorageRestaurantFavourite: RestaurantPersitenceStorage {

  func removeFavouriteRestaurant(restaurant: RestaurantDTO, completion: @escaping StoragePersistenceCompletion<RestaurantDTO>) {
  }

  func getFavouriteRestaurantList(completion: @escaping StoragePersistenceCompletion<[RestaurantDTO]>) {

  }

  func saveFavouriteRestaurant(restautant: RestaurantDTO, completion: @escaping StoragePersistenceCompletion<RestaurantDTO>) {

  }
}

