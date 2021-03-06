//
//  AppFactory.swift
//  Minifork
//
//  Created by Felipe Fernandes on 17/12/21.
//

import Foundation


struct RepositoryFactory {

  func makePictureRepository() -> RepositoryPicture {
    let cache = DefaultCacheStorage(cache: DefaultCacheStorage.global)
    let repository = DefaultRepositoryPicture(cache)
    return repository
  }

  func makeRestaurantListRepository() -> RepositoryRestaurantList {
    let service = ServicesFactory().createRestaurantListService()
    let repository = DefaultRepositoryRestaurantList(service: service)
    return repository
  }

  func makeRestaurantFavouriteRepository() -> RepositoryFavouriteRestaurant {
    let defaultStorage = DefaultStorageRestaurantFavourite()
    let repository = DefaultRespositoryFavourite(storage: defaultStorage)
    return repository
  }

}
