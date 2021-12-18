//
//  Picture-getRestaurantImage-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 17/12/21.
//

import Foundation


final class UsercaseGetPicture: UserCase {

  typealias ResultValue = (Result<Data, Error>)

  private var repository: RepositoryPicture
  private var completion: (ResultValue) -> Void
  private var key: DefaultCacheKey

  init(repository: RepositoryPicture,
       key: DefaultCacheKey,
       completion: @escaping (ResultValue) -> Void) {

  self.repository = repository
  self.completion = completion
  self.key = key
  }

  func start() {
    repository.getPicture(key: key, fromService: completion, fromCache: completion)
  }
}
