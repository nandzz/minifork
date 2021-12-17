//
//  AppFactory.swift
//  Minifork
//
//  Created by Felipe Fernandes on 17/12/21.
//

import Foundation


struct RepositoryFactory {

  func makePictureRepository() -> RepositoryPicture {
    let cache = DefaultCacheStorage(cache: NSCache<DefaultCacheKey, DefaultCacheItem>())
    let repository = DefaultRepositoryPicture(cache)
    return repository
  }

  func makeRestaurantListRepository() -> RepositoryRestaurantList {
    let service = ServicesFactory().createRestaurantListService()
    let repository = DefaultRepositoryRestaurantList(service: service)
    return repository
  }

}
