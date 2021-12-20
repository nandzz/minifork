//
//  UsecaseFactory.swift
//  Minifork
//
//  Created by Felipe Fernandes on 17/12/21.
//

import Foundation




struct UserCaseFactory {

  func makeGetListUserCase() -> UserCaseRestaurantGetList {
    let repository = RepositoryFactory().makeRestaurantListRepository()
    let favoriteRepository = RepositoryFactory().makeRestaurantFavouriteRepository()
    return UserCaseRestaurantGetList(repository: repository, favouriteRepository: favoriteRepository)
  }

  func makeSortUserCase () -> UserCaseSortRestaurant {
    return UserCaseSortRestaurant()
  }

  func makeSaveFavUserCase () -> UserCaseSaveFavouriteRestaurant {
    let repository = RepositoryFactory().makeRestaurantFavouriteRepository()
    return UserCaseSaveFavouriteRestaurant(repository: repository)
  }

  func makeRemoveFavUseCase () -> UserCaseRemoveFavouriteRestaurant  {
    let repository = RepositoryFactory().makeRestaurantFavouriteRepository()
    return UserCaseRemoveFavouriteRestaurant(repository: repository)
  }

  func makeGetImageUserCase () -> UsercaseGetPicture {
    let repository = RepositoryFactory().makePictureRepository()
    return UsercaseGetPicture(repository: repository)
  }

  func makeShareUserCase () -> UsercaseRestaurantShare {
    return UsercaseRestaurantShare()
  }

  func makeGetFavListUserCase () -> UserCaseGetFavouriteRestaurantList {
    let repository = RepositoryFactory().makeRestaurantFavouriteRepository()
    return UserCaseGetFavouriteRestaurantList(repository: repository)
  }

}
