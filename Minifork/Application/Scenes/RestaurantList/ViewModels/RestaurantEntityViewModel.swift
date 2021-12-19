//
//  RestaurantCellViewModel.swift
//  Minifork
//
//  Created by Felipe Fernandes on 19/12/21.
//

import Foundation
import RxSwift
import RxCocoa


final class RestaurantEntityViewModel: ViewModelType {

  struct Input {
    let shareRestaurant: Driver<Restaurant>
    let saveFavourite: Driver<Restaurant>
    let removeFavourite: Driver<Restaurant>
//    let resolvePicture: Driver<Restaurant>
  }

  struct Output {
    let shared: Driver<String>
    let saved: Driver<Void>
    let removed: Driver<Void>
//    let picture: Driver<Data>
//    let error: Driver<Error>
  }


  var shareUseCase: UsercaseRestaurantShare
  var saveFavourite: UserCaseSaveFavouriteRestaurant
  var removeFavourite: UserCaseRemoveFavouriteRestaurant
  var picture: UsercaseGetPicture
  var restaurant: Restaurant
  

  init(share: UsercaseRestaurantShare,
       saveFavourite: UserCaseSaveFavouriteRestaurant,
       removeFavourite: UserCaseRemoveFavouriteRestaurant,
       picture: UsercaseGetPicture,
       restaurant: Restaurant) {
    self.shareUseCase = share
    self.saveFavourite = saveFavourite
    self.removeFavourite = removeFavourite
    self.picture = picture
    self.restaurant = restaurant
  }


  func transform(input: Input) -> Output {

    let shared: Driver<String> = input.shareRestaurant.flatMapLatest { restaurant in
      self.shareUseCase.setRestaurant(restaurant)
      return self.shareUseCase.start().asDriverOnErrorJustComplete()
    }

    let save: Driver<Void> = input.saveFavourite.flatMapLatest { restaurant in
      self.saveFavourite.setRestaurant(restaurant: restaurant)
      return self.saveFavourite.start().asDriverOnErrorJustComplete()
    }

    let remove: Driver<Void> = input.removeFavourite.flatMapLatest { restaurant in
      self.saveFavourite.setRestaurant(restaurant: restaurant)
      return self.removeFavourite.
    }
    
    return Output(shared: shared)
  }

}
