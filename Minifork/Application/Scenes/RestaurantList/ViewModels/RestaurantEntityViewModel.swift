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

  var pictureUseCase: UserCase
  var restaurant: Restaurant

  init(picture: UserCase,
       restaurant: Restaurant) {
    self.restaurant = restaurant
    self.pictureUseCase = picture
  }
  
  func transform(input: Input) -> Output {
    let picture: Driver<Data> = input.resolvePicture.flatMapLatest { restaurant in
      self.pictureUseCase = UserCaseFactory().makeGetImageUserCase(restaurant)
      return self.pictureUseCase.start()
        .map { guard let data = $0 as? Data else { return Data() }
              return data }
        .asDriver(onErrorJustReturn: Data())
    }
    return Output(picture: picture)}
}
