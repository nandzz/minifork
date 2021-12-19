//
//  Restaurant-getFav-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation
import RxSwift


final class UserCaseGetFavouriteRestaurantList: UserCase {
  
  typealias observed = RestaurantList

  private var repository: RepositoryFavouriteRestaurant
  private var restaurant: Restaurant


  init(repository: RepositoryFavouriteRestaurant,
       restaurant: Restaurant) {
    self.repository = repository
    self.restaurant = restaurant
  }

  func start() -> Observable<RestaurantList> {
    return Observable.create { observe in
      self.repository.restoreListOfFavourite { result in
        switch result {
        case .success(let list):
          observe.onNext(list)
          observe.onCompleted()
        case .failure(let error):
          observe.onError(error)
        }
      }
      return Disposables.create()
    }
  }
}
