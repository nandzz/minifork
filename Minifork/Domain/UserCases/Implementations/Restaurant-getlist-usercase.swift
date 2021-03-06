//
//  restaurant-getlist-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation
import RxSwift

protocol UserCaseRestaurantGetList {
  func start() -> Observable<RestaurantList>
}

final class DefaultUserCaseRestaurantList: UserCaseRestaurantGetList {

  private let repository: RepositoryRestaurantList
  private let favouriteReposiroty: RepositoryFavouriteRestaurant

  init(repository: RepositoryRestaurantList, favouriteRepository: RepositoryFavouriteRestaurant ) {
    self.repository = repository
    self.favouriteReposiroty = favouriteRepository
  }

  /// Cast the result value to RestaurantList
  func start() -> Observable<RestaurantList> {
    return Observable.create { observe in
      self.repository.getRestaurantList { result in
        switch result {
        case .success(let serviceList):
          self.favouriteReposiroty.restoreListOfFavourite { localStorage in
            switch localStorage {
            case .success(let savedList):
              var newlist: [Restaurant] = []
              serviceList.toDomain().list.forEach { restaurant in
                if savedList.list.contains(where: {$0.uuid == restaurant.uuid }) {
                  let newRestaurant = restaurant
                  newRestaurant.isFavourite = true
                  newlist.append(newRestaurant)
                } else {
                  newlist.append(restaurant)
                }
              }
              observe.onNext(RestaurantList(list: newlist))
              observe.onCompleted()
            case .failure(_):
              // If error happens still return the list without favourite
              observe.onNext(serviceList.toDomain())
              observe.onCompleted()
            }
          }

        case .failure(let error):
          observe.onError(error)
        }
      }
      return Disposables.create()
    }
  }
}
