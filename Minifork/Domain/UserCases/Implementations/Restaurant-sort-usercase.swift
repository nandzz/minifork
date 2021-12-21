//
//  Restaurant-sort-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 19/12/21.
//

import Foundation
import RxSwift

enum SortType {
  case byRate
  case byName
  case none
}

protocol UserCaseSortRestaurant {
  func start(type: SortType, _ restaurant: [Restaurant]) -> Observable<[Restaurant]>
}

final class DefaultUserCaseSortRestaurant: UserCaseSortRestaurant {
  func start(type: SortType, _ restaurants: [Restaurant]) -> Observable<[Restaurant]> {
    Observable.create { observe in
      switch type {
      case .byName:
        let newList = restaurants.sorted { $0.name < $1.name }
        observe.onNext(newList)
      case .byRate:
        let newList = restaurants.sorted { lfs, rhs in
          let leftTotal = lfs.aggregateRatings.tripadvisor.ratingValue + lfs.aggregateRatings.thefork.ratingValue
          let rightTotal = rhs.aggregateRatings.tripadvisor.ratingValue + rhs.aggregateRatings.thefork.ratingValue
          return leftTotal > rightTotal
        }
        observe.onNext(newList)
      case .none:
        observe.onNext(restaurants)
      }
      return Disposables.create()
    }
  }

}
