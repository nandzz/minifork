//
//  Restaurant-getFav-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation
import RxSwift

protocol UserCaseGetGavouriteRestaurantList {
    func start() -> Observable<RestaurantList>
}

final class DefaultUserCaseGetFavouriteRestaurantList: UserCaseGetGavouriteRestaurantList {
  
  private var repository: RepositoryFavouriteRestaurant
  
  init(_ repository: RepositoryFavouriteRestaurant) {
    self.repository = repository
  }
  
  /// Cast Type: `RestaurantList`
func start() -> Observable<RestaurantList> {
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
