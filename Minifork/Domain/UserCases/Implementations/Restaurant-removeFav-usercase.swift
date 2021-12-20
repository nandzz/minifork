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
  private var restaurant: Restaurant?

  init(repository: RepositoryFavouriteRestaurant) {
    self.repository = repository
  }

  func setFavourite(restaurant: Restaurant) {
    self.restaurant = restaurant
  }

  func start() -> Observable<Void> {
    return Observable.create { observe in
      guard let restaurant = self.restaurant else {
        observe.onError(UsercaseErros.Generic)
        return Disposables.create()
      }
      self.repository.removeRestaurantFromFavourite(uuid: restaurant.uuid) { result in
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
