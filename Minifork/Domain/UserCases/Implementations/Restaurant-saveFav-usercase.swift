//
//  Restaurant-saveFav-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation
import RxSwift

final class UserCaseSaveFavouriteRestaurant: UserCase {

  typealias observed = Void

  private var repository: RepositoryFavouriteRestaurant
  private var restaurant: Restaurant?

  init(repository: RepositoryFavouriteRestaurant) {
    self.repository = repository
  }

  func setRestaurant(restaurant: Restaurant) {
    self.restaurant = restaurant
  }
  
  func start() -> Observable<Void> {
    let dto = restaurant?.toDTO()
    return Observable.create { observe in
      guard let requestedData = dto else {
        observe.onError(NetworkTypeError.ErrorDecoding)
        return Disposables.create()
      }
      self.repository.saveFavourite(restaurant: requestedData) { result in
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
