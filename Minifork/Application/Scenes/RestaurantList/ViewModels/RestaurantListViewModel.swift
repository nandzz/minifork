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

  }

  struct Output {
    let list: Driver<[RestaurantEntityViewModel]>
  }

  private let listUserCase: UserCaseRestaurantGetList

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
