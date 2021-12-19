//
//  ViewModelType.swift
//  Minifork
//
//  Created by Felipe Fernandes on 19/12/21.
//

import Foundation
import RxSwift
import RxCocoa

final class RestaurantListViewModel: ViewModelType {


  enum SortType {
    case byRate
    case byName
  }

  struct Input {
    let start: Driver<Void>
//    let saveFavourite: Driver<Restaurant>
//    let deleteFavourite: Driver<Restaurant>
//    let share: Driver<Restaurant>
//    let sort: Driver<SortType>
  }

  struct Output {
    let list: Driver<[RestaurantEntityViewModel]>
//    let savedRestaurant: Driver<Restaurant>
//    let deletedRestaurant: Driver<Restaurant>
//    let sharedRestaurant: Driver<Restaurant>
  }

  private let listUserCase: UserCaseRestaurantGetList
//  private let saveUserCase: UserCaseSaveFavouriteRestaurant
//  private let removeUserCase: UserCaseRemoveFavouriteRestaurant


  init(listUserCase: UserCaseRestaurantGetList) {
    self.listUserCase = listUserCase
  }


  func transform(input: Input) -> Output {

    let list = input.start.flatMapLatest{
      return self.listUserCase.start()
        .asDriver(onErrorJustReturn: RestaurantList(list: []))
        .map { $0.list.map { ViewModelFactory().CreateRestaurantEntityViewModel(restaurant: $0) }}
    }

    return Output(list: list)
  }


}
