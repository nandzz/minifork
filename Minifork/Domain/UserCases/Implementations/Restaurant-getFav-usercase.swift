//
//  Restaurant-getFav-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation


final class UserCaseGetFavouriteRestaurantList: UserCase {

  typealias ResultValue = (Result<RestaurantList, Error>)

  private var repository: RepositoryFavouriteRestaurant
  private var completion: (ResultValue) -> Void
  private var restaurant: Restaurant


  init(repository: RepositoryFavouriteRestaurant,
       restaurant: Restaurant,
       completion: @escaping (ResultValue) -> Void
    ) {
    self.repository = repository
    self.restaurant = restaurant
    self.completion = completion
  }

  func start() {
    repository.restoreListOfFavourite(completion: completion)
  }

}
