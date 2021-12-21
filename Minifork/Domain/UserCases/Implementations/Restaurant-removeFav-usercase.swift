//
//  Restaurant-removeFav-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 18/12/21.
//

import Foundation
import RxSwift

protocol UserCaseRemoveFavouriteRestaurant {
  func start(_ restaurant: Restaurant) -> Observable<Void>
}

final class DefaultUserCaseRemoveFavouriteRestaurant: UserCaseRemoveFavouriteRestaurant {

  private var repository: RepositoryFavouriteRestaurant

  init(_ repository: RepositoryFavouriteRestaurant) {
    self.repository = repository
  }

  /// Cast output type to `Void`
  func start(_ restaurant: Restaurant) -> Observable<Void> {
    return Observable.create { observe in
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
