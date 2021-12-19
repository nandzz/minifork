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
  private var key: DefaultCacheKey?

  init(repository: RepositoryPicture) {
    self.repository = repository
  }

  func setKey(key: DefaultCacheKey) {
    self.key = key
  }


  func start() -> Observable<Data> {
    return Observable.create { observe in
      guard let key = self.key else {
        observe.onError(NetworkTypeError.ErrorDecoding)
        return Disposables.create()
      }

      self.repository.getPicture(key: key) { result in
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
