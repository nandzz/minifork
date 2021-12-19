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
    let favourite: Driver<Restaurant>
    let resolvePicture: Driver<Restaurant>
  }

  struct Output {
    let shared: Driver<String>
    let changeRestaurantFavState: Driver<Bool>
    let picture: Driver<Data>
  }


  var shareUseCase: UsercaseRestaurantShare
  var saveFavouriteUsercase: UserCaseSaveFavouriteRestaurant
  var removeFavouriteUsercase: UserCaseRemoveFavouriteRestaurant
  var pictureUseCase: UsercaseGetPicture
  var restaurant: Restaurant
  /// Used to save the item in the the cache
  private var restaurantKey: DefaultCacheKey

  init(share: UsercaseRestaurantShare,
       saveFavourite: UserCaseSaveFavouriteRestaurant,
       removeFavourite: UserCaseRemoveFavouriteRestaurant,
       picture: UsercaseGetPicture,
       restaurant: Restaurant) {
    self.shareUseCase = share
    self.saveFavouriteUsercase = saveFavourite
    self.removeFavouriteUsercase = removeFavourite
    self.pictureUseCase = picture
    self.restaurant = restaurant
    self.restaurantKey = DefaultCacheKey(url: restaurant.mainPhoto?.medium ?? "")
  }


  func transform(input: Input) -> Output {

    let shared: Driver<String> = input.shareRestaurant.flatMapLatest { restaurant in
      self.shareUseCase.setRestaurant(restaurant)
      return self.shareUseCase.start().asDriver(onErrorJustReturn: "")
    }

    let favourite: Driver<Bool> = input.favourite.flatMapLatest { restaurant in
      if !restaurant.isFavourite {
        self.saveFavouriteUsercase.setRestaurant(restaurant: self.restaurant)
        return self.saveFavouriteUsercase.start().asDriver(onErrorJustReturn: ()).map{true}
      } else {
        self.removeFavouriteUsercase.setFavourite(restaurant: self.restaurant)
        return self.removeFavouriteUsercase.start().asDriver(onErrorJustReturn: ()).map{false}
      }
    }

    let picture: Driver<Data> = input.resolvePicture.flatMapLatest { restaurant in
      self.pictureUseCase.setKey(key: self.restaurantKey)
      return self.pictureUseCase.start().asDriver(onErrorJustReturn: Data())
    }
    
    return Output(
      shared: shared,
      changeRestaurantFavState: favourite,
      picture: picture)
  }

}
