//
//  Restaurant-sort-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 19/12/21.
//

import Foundation
import RxSwift


final class UserCaseSortRestaurant: UserCase {

  enum SortType {
    case byRate
    case byName
    case none
  }

  typealias observed = [Restaurant]

  private var restaurants: [Restaurant] = []
  private var type: SortType = .none

  func setRestaurants (_ restaurants: [Restaurant]) {
    self.restaurants = restaurants
  }

  func setType (_ type: SortType) {
    self.type = type
  }

  func start() -> Observable<[Restaurant]> {
    Observable.create { observe in
      switch self.type {
      case .byName:
        let newList = self.restaurants.sorted { $0.name < $1.name }
        observe.onNext(newList)
      case .byRate:
        let newList = self.restaurants.sorted { lfs, rhs in
          let leftTotal = lfs.aggregateRatings.tripadvisor.ratingValue + lfs.aggregateRatings.thefork.ratingValue
          let rightTotal = rhs.aggregateRatings.tripadvisor.ratingValue + rhs.aggregateRatings.thefork.ratingValue
          return leftTotal > rightTotal
        }
        observe.onNext(newList)
      case .none:
        observe.onNext(self.restaurants)
      }
      return Disposables.create()
    }
  }

}
