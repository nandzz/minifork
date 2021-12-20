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

  private let listUserCase: UserCaseRestaurantGetList
  private let sortUserCase: UserCaseSortRestaurant
  private let shareUseCase: UsercaseRestaurantShare
  private let saveFavouriteUsercase: UserCaseSaveFavouriteRestaurant
  private let removeFavouriteUserCase: UserCaseRemoveFavouriteRestaurant
  private var disposableBag = DisposeBag()
  private var list: [Restaurant] = []
 

  init(listUserCase: UserCaseRestaurantGetList,
       sort: UserCaseSortRestaurant,
       share: UsercaseRestaurantShare,
       savFav: UserCaseSaveFavouriteRestaurant,
       removFav: UserCaseRemoveFavouriteRestaurant) {

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
      return self.listUserCase.start().map { list -> [RestaurantEntityViewModel] in
        self.list = list.list
        let model = list.list.map { ViewModelFactory().CreateRestaurantEntityViewModel(restaurant: $0)}
        return model
      }.asDriverOnErrorJustComplete()
    }

    let sorted: Driver<[RestaurantEntityViewModel]> = input.sort.flatMapLatest { type in
      self.sortUserCase.setType(type)
      self.sortUserCase.setRestaurants(self.list)
      return self.sortUserCase.start().map { restaurants -> [RestaurantEntityViewModel] in
        self.list = restaurants
        let models: [RestaurantEntityViewModel] = restaurants.map { restaurant in
          ViewModelFactory().CreateRestaurantEntityViewModel(restaurant: restaurant)
        }
        return models
      }.asDriverOnErrorJustComplete()
    }


    let fav: Driver<[RestaurantEntityViewModel]> = input.favourite.flatMapLatest { restaurant in
      if !restaurant.isFavourite {
        self.saveFavouriteUsercase.setRestaurant(restaurant: restaurant)
        return self.saveFavouriteUsercase.start().map { saved -> [RestaurantEntityViewModel] in
            let models: [RestaurantEntityViewModel] = self.list.map { toModel in
            if toModel.uuid == restaurant.uuid { toModel.isFavourite = true }
            return ViewModelFactory().CreateRestaurantEntityViewModel(restaurant: toModel)
          }
          return models
        }.asDriverOnErrorJustComplete()
      } else {
        self.removeFavouriteUserCase.setFavourite(restaurant: restaurant)
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
      self.shareUseCase.setRestaurant(restaurant)
      return self.shareUseCase.start().asDriver(onErrorJustReturn: "")
    }

    return Output(started: started, sorted: sorted, share: shared, favourite: fav)
  }




}
