//
//  Restaurant-saveFav-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation
import RxSwift

protocol UserCaseSaveFavouriteRestaurant {
  func start(_ restaurant: Restaurant) -> Observable<Restaurant>
}

final class DefaultUserCaseSaveFavouriteRestaurant: UserCaseSaveFavouriteRestaurant {

  private var repository: RepositoryFavouriteRestaurant

  init(_ repository: RepositoryFavouriteRestaurant) {
    self.repository = repository
  }

  func start(_ restaurant: Restaurant) -> Observable<Restaurant> {
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
