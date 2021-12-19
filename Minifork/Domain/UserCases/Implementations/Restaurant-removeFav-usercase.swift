//
//  Restaurant-removeFav-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 18/12/21.
//

import Foundation
import RxSwift


final class UserCaseRemoveFavouriteRestaurant: UserCase {

  typealias observed = Void

  private var repository: RepositoryFavouriteRestaurant
  private var restaurant: Restaurant

  init(repository: RepositoryFavouriteRestaurant,
       restaurant: Restaurant) {
    self.repository = repository
    self.restaurant = restaurant
  }


  func start() -> Observable<Void> {
    return Observable.create { observe in
      self.repository.removeRestaurantFromFavourite(uuid: self.restaurant.uuid) { result in
        switch result {
        case .success(_):
          observe.onNext(())
          observe.onCompleted()
        case .failure(let error):
          observe.onError(error)
        }
      }
      return Disposables.create()
    }
  }
}
