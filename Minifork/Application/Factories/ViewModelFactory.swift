//
//  ViewModelFactories.swift
//  Minifork
//
//  Created by Felipe Fernandes on 17/12/21.
//

import Foundation



struct ViewModelFactory  {


  func CreateRestaurantEntityViewModel(restaurant: Restaurant) -> RestaurantEntityViewModel {
    let favouriteRepository = RepositoryFactory().makeRestaurantFavouriteRepository()
    let pictureRepository = RepositoryFactory().makePictureRepository()

    return RestaurantEntityViewModel(share: UsercaseRestaurantShare(),
                                     saveFavourite: UserCaseSaveFavouriteRestaurant(repository: favouriteRepository),
                                     removeFavourite: UserCaseRemoveFavouriteRestaurant(repository: favouriteRepository),
                                     picture: UsercaseGetPicture(repository: pictureRepository),
                                     restaurant: restaurant)
  }


  func createRestaurantListViewModel() -> RestaurantListViewModel {
    let repository = RepositoryFactory().makeRestaurantListRepository()
    let favRepository = RepositoryFactory().makeRestaurantFavouriteRepository()
    return RestaurantListViewModel(listUserCase: UserCaseRestaurantGetList(repository: repository,
                                                                           favouriteRepository: favRepository))
  }
  

}
