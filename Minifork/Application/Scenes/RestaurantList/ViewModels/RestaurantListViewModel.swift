//
//  ViewModelType.swift
//  Minifork
//
//  Created by Felipe Fernandes on 19/12/21.
//

import Foundation
import RxSwift
import RxCocoa
//
//final class RestaurantListViewModel: ViewModelType {
//
//
//  enum SortType {
//    case byRate
//    case byName
//  }
//
//  struct Input {
//    let start: Driver<Void>
//    let saveFavourite: Driver<Restaurant>
//    let deleteFavourite: Driver<Restaurant>
//    let share: Driver<Restaurant>
//    let sort: Driver<SortType>
//  }
//
//  struct Output {
//    let list: Driver<RestaurantList>
//    let savedRestaurant: Driver<Restaurant>
//    let deletedRestaurant: Driver<Restaurant>
//    let sharedRestaurant: Driver<Restaurant>
//  }
//
//  private let listUserCase: UserCaseRestaurantGetList
//  private let saveUserCase: UserCaseSaveFavouriteRestaurant
//  private let removeUserCase: UserCaseRemoveFavouriteRestaurant
//
//
//  init(listUserCase: UserCaseRestaurantGetList,
//       saveUserCase: UserCaseSaveFavouriteRestaurant,
//       removeUserCase: UserCaseRemoveFavouriteRestaurant) {
//    self.listUserCase = listUserCase
//    self.saveUserCase = saveUserCase
//    self.removeUserCase = removeUserCase
//  }
//
//
//  func transform(input: Input) -> Output {
//
////    let list = input.start.flatMapLatest {
////      return listUserCase.start()
////    }
//
//
////    let listOutput = Observable<RestaurantList>.create { observe -> Disposable in
////      listUserCase.completion = { result in
////        switch result {
////        case .
////        }
////
////      }
////    }
//    
//
//
//  }
//
//
//}
