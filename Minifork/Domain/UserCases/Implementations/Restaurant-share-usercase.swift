//
//  restaurant-share-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 19/12/21.
//

import Foundation
import RxSwift

final class UsercaseRestaurantShare: UserCase {

  typealias observed = String
  
  private var restaurant: Restaurant?

  init() {}


  func setRestaurant (_ restaurant: Restaurant) {
    self.restaurant = restaurant
  }

  func start() -> Observable<String> {
    return Observable.create { observe in
      guard let item = self.restaurant else {
        observe.onError(UsercaseErros.Generic)
        return Disposables.create()
      }
      var msg = """
      Hello, I just found this nice restaurant called \(item.name) in \(item.address.street), \(item.address.locality)-\(item.address.country), take a look!

      Serves: \(item.servesCuisine)
      Tripadvisor Rate: \(item.aggregateRatings.tripadvisor.ratingValue)/5
      TheFork Rate: \(item.aggregateRatings.thefork.ratingValue)/10
      PriceRange: 0-\(item.priceRange)
      Currency Accepted: "\(item.currenciesAccepted)"

      """
      if let photos = item.mainPhoto {
        msg += "Image: \(photos.big)"
      }

      observe.onNext(msg)
      observe.onCompleted()
      return Disposables.create()
    }
  }
}
