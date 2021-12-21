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
    return DefaultUserCaseRestaurantList(repository: repository, favouriteRepository: favoriteRepository)
  }

  func makeSortUserCase () -> UserCaseSortRestaurant {
    return DefaultUserCaseSortRestaurant()
  }

  func makeSaveFavUserCase () -> UserCaseSaveFavouriteRestaurant {
    let repository = RepositoryFactory().makeRestaurantFavouriteRepository()
    return DefaultUserCaseSaveFavouriteRestaurant(repository)
  }

  func makeRemoveFavUseCase () -> UserCaseRemoveFavouriteRestaurant  {
    let repository = RepositoryFactory().makeRestaurantFavouriteRepository()
    return DefaultUserCaseRemoveFavouriteRestaurant(repository)
  }

  func makeGetImageUserCase () -> UserCaseGetPicture {
    let repository = RepositoryFactory().makePictureRepository()
    return DefaultUserCaseGetImage(repository)
  }

  func makeShareUserCase () -> UserCaseRestaurantShare {
    return DefaultUsercaseRestaurantShare()
  }

  func makeGetFavListUserCase () -> UserCaseSaveFavouriteRestaurant {
    let repository = RepositoryFactory().makeRestaurantFavouriteRepository()
    return DefaultUserCaseSaveFavouriteRestaurant(repository)
  }

}
