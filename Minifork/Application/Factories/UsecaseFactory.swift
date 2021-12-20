//
//  UsecaseFactory.swift
//  Minifork
//
//  Created by Felipe Fernandes on 17/12/21.
//

import Foundation




struct UserCaseFactory {

  func makeGetListUserCase() -> UserCase {
    let repository = RepositoryFactory().makeRestaurantListRepository()
    let favoriteRepository = RepositoryFactory().makeRestaurantFavouriteRepository()
    return UserCaseRestaurantGetList(repository: repository, favouriteRepository: favoriteRepository)
  }

  func makeSortUserCase (_ type: UserCaseSortRestaurant.SortType, _ restaurants: [Restaurant]) -> UserCase {
    return UserCaseSortRestaurant(type, restaurants)
  }

  func makeSaveFavUserCase (_ restaurant: Restaurant?) -> UserCase {
    let repository = RepositoryFactory().makeRestaurantFavouriteRepository()
    return UserCaseSaveFavouriteRestaurant(repository, restaurant)
  }

  func makeRemoveFavUseCase (_ restaurant: Restaurant?) -> UserCase  {
    let repository = RepositoryFactory().makeRestaurantFavouriteRepository()
    return UserCaseRemoveFavouriteRestaurant(repository, restaurant)
  }

  func makeGetImageUserCase (_ restaurant: Restaurant) -> UserCase {
    let repository = RepositoryFactory().makePictureRepository()
    return UsercaseGetPicture(repository, restaurant)
  }

  func makeShareUserCase (_ restaurant: Restaurant?) -> UserCase {
    return UsercaseRestaurantShare(restaurant)
  }

  func makeGetFavListUserCase () -> UserCase {
    let repository = RepositoryFactory().makeRestaurantFavouriteRepository()
    return UserCaseGetFavouriteRestaurantList(repository: repository)
  }

}
