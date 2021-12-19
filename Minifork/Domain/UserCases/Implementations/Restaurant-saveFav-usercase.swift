//
//  Restaurant-saveFav-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation
import RxSwift

final class UserCaseSaveFavouriteRestaurant: UserCase {

  typealias observed = Restaurant

  private var repository: RepositoryFavouriteRestaurant
  private var restaurant: Restaurant


  init(repository: RepositoryFavouriteRestaurant,
       restaurant: Restaurant) {
    self.repository = repository
    self.restaurant = restaurant
  }
  
  func start() -> Observable<Restaurant> {
    let dto = restaurant.toDTO()
    return Observable.create { observe in
      self.repository.saveFavourite(restaurant: dto) { result in
        switch result {
        case .success(let restaurant):
          observe.onNext(restaurant)
          observe.onCompleted()
        case .failure(let error):
          observe.onError(error)
        }
      }
      return Disposables.create()
    }
  }
}
