//
//  CacheInterface.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation

protocol RestaurantPersitenceStorage {
  func getFavouriteRestaurantList(completion: @escaping StoragePersistenceCompletion<[RestaurantDTO]>)
  func saveFavouriteRestaurant(restautant: RestaurantDTO, completion: @escaping StoragePersistenceCompletion<RestaurantDTO>)
  func removeFavouriteRestaurant(restaurant: RestaurantDTO, completion: @escaping StoragePersistenceCompletion<RestaurantDTO>)
}
