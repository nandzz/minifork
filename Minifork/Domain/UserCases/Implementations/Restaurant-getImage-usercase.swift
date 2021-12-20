//
//  Picture-getRestaurantImage-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 17/12/21.
//

import Foundation
import RxSwift


final class UsercaseGetPicture: UserCase {

  typealias observed = Data

  private var repository: RepositoryPicture
  private var restaurant: Restaurant?

  init(repository: RepositoryPicture) {
    self.repository = repository
  }

  func setRestaurant(restaurant: Restaurant) {
    self.restaurant = restaurant
  }

  func start() -> Observable<Data> {

    return Observable.create { observe in
      guard let restaurant = self.restaurant else {
        observe.onError(UsercaseErros.Generic)
        return Disposables.create()
      }
      self.repository.getPicture(restaurant: restaurant.toDTO()) { result in
        switch result {
        case .success(let data):
          observe.onNext(data)
          observe.onCompleted()
        case .failure(let error):
          observe.onError(error)
        }
      } fromCache: { result in
        switch result {
        case .success(let data):
          observe.onNext(data)
          observe.onCompleted()
        case .failure(let error):
          observe.onError(error)
        }
      }
      return Disposables.create()
    }
  }
}
