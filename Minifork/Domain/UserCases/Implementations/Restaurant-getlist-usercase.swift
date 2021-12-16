//
//  restaurant-getlist-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation


final class UserCaseRestaurantGetList: UserCase {

  typealias ResultValue = (Result<RestaurantList, Error>)

  private let repository: RepositoryRestaurantList
  private let completion: (ResultValue) -> Void


  init(repository: RepositoryRestaurantList,
       completion: @escaping (ResultValue) -> Void ) {
    self.repository = repository
    self.completion = completion
  }

  func start() {
      self.repository.getRestaurantList { result in
          switch result {
          case .success(let restaurant):
            self.completion(.success(restaurant.toDomain()))
          case .failure(let error):
            self.completion(.failure(error))
          }
      }
  }


}
