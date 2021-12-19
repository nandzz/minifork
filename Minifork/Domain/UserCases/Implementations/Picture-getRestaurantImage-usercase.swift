//
//  Picture-getRestaurantImage-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 17/12/21.
//

import Foundation
import RxSwift


final class UsercaseGetPicture: UserCase {



  typealias observed = Data

  private var repository: RepositoryPicture
  private var key: DefaultCacheKey

  init(repository: RepositoryPicture,
       key: DefaultCacheKey) {

  self.repository = repository
  self.key = key
  }


  func start() -> Observable<Data> {
    return Observable.create { observe in
      self.repository.getPicture(key: self.key) { result in
        switch result {
        case .success(let data):
          observe.onNext(data)
          observe.onCompleted()
        case .failure(let error):
          observe.onError(error)
        }
      } fromCache: { result in
        switch result {
        case .success(let data):
          observe.onNext(data)
          observe.onCompleted()
        case .failure(let error):
          observe.onError(error)
        }
      }
      return Disposables.create()
    }
  }
}
