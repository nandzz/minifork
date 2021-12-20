//
//  ViewModelFactories.swift
//  Minifork
//
//  Created by Felipe Fernandes on 17/12/21.
//

import Foundation



struct ViewModelFactory  {


  func CreateRestaurantEntityViewModel(restaurant: Restaurant) -> RestaurantEntityViewModel {
    let factory = UserCaseFactory()
    let pictureUserCase = factory.makeGetImageUserCase(restaurant)

    return RestaurantEntityViewModel(picture: pictureUserCase,
                                     restaurant: restaurant)
  }


  func createRestaurantListViewModel() -> RestaurantListViewModel {
    // Usercases
    let factory = UserCaseFactory()
    let shareUserCase = factory.makeShareUserCase(nil)
    let listUserCase =  factory.makeGetListUserCase()
    let sortUserCase =  factory.makeSortUserCase(.none, [])
    let saveFavUserCase = factory.makeSaveFavUserCase(nil)
    let removeFavUserCase = factory.makeRemoveFavUseCase(nil)


    return RestaurantListViewModel(listUserCase: listUserCase,
                                   sort: sortUserCase,
                                   share: shareUserCase,
                                   savFav: saveFavUserCase,
                                   removFav: removeFavUserCase)
  }
  

}
