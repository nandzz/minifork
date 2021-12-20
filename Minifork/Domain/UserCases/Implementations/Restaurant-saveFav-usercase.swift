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
  private var restaurant: Restaurant?

  init(_ repository: RepositoryFavouriteRestaurant,_ restaurant: Restaurant?) {
    self.repository = repository
    self.restaurant = restaurant
  }

  /// Cast output type to `Restaurant`
  func start() -> Observable<Any> {
    let dto = restaurant?.toDTO()
    return Observable.create { observe in
      guard let requestedData = dto else {
        observe.onError(UsercaseErros.Generic)
        return Disposables.create()
      }
      self.repository.saveFavourite(restaurant: requestedData) { result in
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
