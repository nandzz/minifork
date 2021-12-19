//
//  restaurant-getlist-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation
import RxSwift

final class UserCaseRestaurantGetList: UserCase {

  typealias observed = RestaurantList
  typealias ResultValue = (Result<RestaurantList, Error>)

  private let repository: RepositoryRestaurantList

  init(repository: RepositoryRestaurantList ) {
    self.repository = repository
  }


  func start() -> Observable<RestaurantList> {
    return Observable.create { observe in
      self.repository.getRestaurantList { result in
        switch result {
        case .success(let restaurant):
          observe.onNext(restaurant.toDomain())
          observe.onCompleted()
        case .failure(let error):
          observe.onError(error)
        }
      }
      return Disposables.create()
    }
  }
}
