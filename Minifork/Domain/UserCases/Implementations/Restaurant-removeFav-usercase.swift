//
//  Restaurant-removeFav-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 18/12/21.
//

import Foundation


final class UserCaseRemoveFavouriteRestaurant: UserCase {

  typealias ResultValue = (Result<Void, Error>)

  private var repository: RepositoryFavouriteRestaurant
  private var completion: (ResultValue) -> Void
  private var restaurant: Restaurant

  init(repository: RepositoryFavouriteRestaurant,
       restaurant: Restaurant,
       completion: @escaping (ResultValue) -> Void) {

  self.repository = repository
  self.completion = completion
  self.restaurant = restaurant
  }

  func start() {
    repository.removeRestaurantFromFavourite(uuid: restaurant.uuid, completion: completion)
  }
}
