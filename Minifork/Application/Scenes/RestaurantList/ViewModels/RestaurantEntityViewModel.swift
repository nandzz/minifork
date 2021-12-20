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
    let resolvePicture: Driver<Restaurant>
  }

  struct Output {
    let picture: Driver<Data>
  }

  var pictureUseCase: UsercaseGetPicture
  var restaurant: Restaurant

  init(picture: UsercaseGetPicture,
       restaurant: Restaurant) {
    self.restaurant = restaurant
    self.pictureUseCase = picture
  }


  func transform(input: Input) -> Output {
    let picture: Driver<Data> = input.resolvePicture.flatMapLatest { restaurant in
      self.pictureUseCase.setKey(key: restaurant.key)
      return self.pictureUseCase.start().asDriver(onErrorJustReturn: Data())
    }
    return Output(picture: picture)}
}
