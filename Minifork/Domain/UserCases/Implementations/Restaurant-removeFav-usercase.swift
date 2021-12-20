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

  init(_ repository: RepositoryFavouriteRestaurant,_ restaurant: Restaurant?) {
    self.repository = repository
    self.restaurant = restaurant
  }

  /// Cast output type to `Void`
  func start() -> Observable<Any> {
    return Observable.create { observe in
      guard let restaurant = self.restaurant else {
        observe.onError(UsercaseErros.ObjectNotPresent)
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
