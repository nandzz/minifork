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
  
  var pictureUseCase: UserCaseGetPicture
  var restaurant: Restaurant
  
  init(picture: UserCaseGetPicture, restaurant: Restaurant) {
    self.pictureUseCase = picture
    self.restaurant = restaurant
  }
  
  func transform(input: Input) -> Output {
    let picture: Driver<Data> = input.resolvePicture.flatMapLatest { restaurant in
      return self.pictureUseCase.start(restaurant)
        .asDriver(onErrorJustReturn: Data())
    }
    return Output(picture: picture)}
}
