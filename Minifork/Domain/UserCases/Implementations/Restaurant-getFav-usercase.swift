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
  
  init(_ repository: RepositoryFavouriteRestaurant) {
    self.repository = repository
  }
  
  /// Cast Type: `RestaurantList`
  func start() -> Observable<Any> {
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
