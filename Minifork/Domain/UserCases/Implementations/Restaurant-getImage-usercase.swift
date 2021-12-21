//
//  Picture-getRestaurantImage-usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 17/12/21.
//

import Foundation
import RxSwift

protocol UserCaseGetPicture {
  func start(_ restaurant: Restaurant) -> Observable<Data>
}

final class DefaultUserCaseGetImage: UserCaseGetPicture {

  private var repository: RepositoryPicture

  init(_ repository: RepositoryPicture) {
    self.repository = repository
  }


  ///Cast type: Data()
  func start(_ restaurant: Restaurant) -> Observable<Data> {
    return Observable.create { observe in
      DispatchQueue.global(qos: .background).async {
        self.repository.getPicture(restaurant: restaurant.toDTO()) { result in
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
      }
      return Disposables.create()
    }
  }
}
