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

  struct Input {
    let start: Driver<Void>
    let sort: Driver<UserCaseSortRestaurant.SortType>
    let share: Driver<Restaurant>
    let favourite: Driver<Restaurant>
  }

  struct Output {
    var started: Driver<[RestaurantEntityViewModel]>
    var sorted: Driver<[RestaurantEntityViewModel]>
    var share: Driver<String>
    var favourite: Driver<[RestaurantEntityViewModel]>
  }

  private let listUserCase: UserCase
  private var sortUserCase: UserCase
  private var shareUseCase: UserCase
  private var saveFavouriteUsercase: UserCase
  private var removeFavouriteUserCase: UserCase
  private var disposableBag = DisposeBag()
  private var list: [Restaurant] = []


  init(listUserCase: UserCase,
       sort: UserCase,
       share: UserCase,
       savFav: UserCase,
       removFav: UserCase) {

    self.listUserCase = listUserCase
    self.sortUserCase = sort
    self.shareUseCase = share
    self.saveFavouriteUsercase = savFav
    self.removeFavouriteUserCase = removFav
  }

  func transform(input: Input) -> Output {

    input.start.drive { _ in
    } onCompleted: {
      print("Fetch completed")
    } onDisposed: {
      print("Disposable")
    }.disposed(by: disposableBag)

    let started: Driver<[RestaurantEntityViewModel]> = input.start.flatMapLatest {
      return self.listUserCase.start().map { objc -> [RestaurantEntityViewModel] in
        guard let restaurant = objc as? RestaurantList else {
          assertionFailure("Casting wrong type")
          return []
        }
        self.list = restaurant.list
        let model = restaurant.list.map { ViewModelFactory().CreateRestaurantEntityViewModel(restaurant: $0)}
        return model
      }.asDriverOnErrorJustComplete()
    }

    let sorted: Driver<[RestaurantEntityViewModel]> = input.sort.flatMapLatest { type in
      // Adapt usercase
      self.sortUserCase = UserCaseFactory().makeSortUserCase(type, self.list)
      return self.sortUserCase.start().map { obj -> [RestaurantEntityViewModel] in
        guard let restaurants = obj as? [Restaurant] else {
          assertionFailure("Casting wrong type")
          return []
        }
        self.list = restaurants
        let models: [RestaurantEntityViewModel] = restaurants.map { restaurant in
          ViewModelFactory().CreateRestaurantEntityViewModel(restaurant: restaurant)
        }
        return models
      }.asDriverOnErrorJustComplete()
    }

    let fav: Driver<[RestaurantEntityViewModel]> = input.favourite.flatMapLatest { restaurant in
      if !restaurant.isFavourite {
        self.saveFavouriteUsercase = UserCaseFactory().makeSaveFavUserCase(restaurant)
        return self.saveFavouriteUsercase.start().map { saved -> [RestaurantEntityViewModel] in
          let models: [RestaurantEntityViewModel] = self.list.map { toModel in
            if toModel.uuid == restaurant.uuid { toModel.isFavourite = true }
            return ViewModelFactory().CreateRestaurantEntityViewModel(restaurant: toModel)
          }
          return models
        }.asDriverOnErrorJustComplete()
      } else {
        self.removeFavouriteUserCase = UserCaseFactory().makeRemoveFavUseCase(restaurant)
        return self.removeFavouriteUserCase.start().map { removed -> [RestaurantEntityViewModel] in
          let models: [RestaurantEntityViewModel] = self.list.map { toModel in
            if toModel.uuid == restaurant.uuid { toModel.isFavourite = false }
            return ViewModelFactory().CreateRestaurantEntityViewModel(restaurant: toModel)
          }
          return models
        }.asDriverOnErrorJustComplete()
      }
    }

    let shared: Driver<String> = input.share.flatMapLatest { restaurant in
      self.shareUseCase = UserCaseFactory().makeShareUserCase(restaurant)
      return self.shareUseCase.start()
        .map {
          guard let promo = $0 as? String else {
            assertionFailure("Casting wrong type")
            return ""
          }
          return promo
        }
        .asDriver(onErrorJustReturn: "")
    }
    return Output(started: started, sorted: sorted, share: shared, favourite: fav)
  }




}
