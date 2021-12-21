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
    let pictureUserCase = factory.makeGetImageUserCase()

    return RestaurantEntityViewModel(picture: pictureUserCase,
                                     restaurant: restaurant)
  }


  func createRestaurantListViewModel() -> RestaurantListViewModel {
    // Usercases
    let factory = UserCaseFactory()
    let shareUserCase = factory.makeShareUserCase()
    let listUserCase =  factory.makeGetListUserCase()
    let sortUserCase =  factory.makeSortUserCase()
    let saveFavUserCase = factory.makeSaveFavUserCase()
    let removeFavUserCase = factory.makeRemoveFavUseCase()


    return RestaurantListViewModel(listUserCase: listUserCase,
                                   sort: sortUserCase,
                                   share: shareUserCase,
                                   savFav: saveFavUserCase,
                                   removFav: removeFavUserCase)
  }
  

}
