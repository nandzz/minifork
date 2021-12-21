//
//  restaurant-share-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 19/12/21.
//

import Foundation
import RxSwift

protocol UserCaseRestaurantShare {
  func start(_ restaurant: Restaurant) -> Observable<String>
}

final class DefaultUsercaseRestaurantShare: UserCaseRestaurantShare {

  func start(_ restaurant: Restaurant) -> Observable<String> {
    return Observable.create { observe in
      var msg = """
      Hello, I just found this nice restaurant called \(restaurant.getName()) in \(restaurant.getAddressStreet()), \(restaurant.getCityCountry()), take a look!

      Serves: \(restaurant.getCousine())
      Tripadvisor Rate: \(restaurant.getTripAdRate())/5
      TheFork Rate: \(restaurant.getTheForkRate())/10
      PriceRange: 0-\(restaurant.getPriceRange())"
      """
      if let photos = restaurant.mainPhoto {
        msg += "Image: \(photos.big)"
      }

      observe.onNext(msg)
      observe.onCompleted()
      return Disposables.create()
    }
  }
}
