//
//  testRestaurantPictureUsercase.swift
//  MiniforkTests
//
//  Created by Felipe Fernandes on 18/12/21.
//

import XCTest
@testable import Minifork
@testable import RxSwift

class testRestaurantPictureUsercase: XCTestCase {

    func testRestaurantGetPictureUsercase() throws {
      let repository = RepositoryFactory().makePictureRepository()
      let key = DefaultCacheKey(url: "https://res.cloudinary.com/tf-lab/image/upload/f_auto,q_auto,w_480,h_270/restaurant/b1d8f006-2477-4715-b937-2c34d616dccb/68e364a6-e903-4fb1-9e1e-d91d97457266.jpg")
      let expectation = XCTestExpectation(description: "test-getpicture-usercase")
      let disposeBag = DisposeBag()
      let getUsercase =  UsercaseGetPicture(repository: repository)
      getUsercase.setKey(key: key)
      let observable = getUsercase.start()

      observable.subscribe { data in
        print(data)
      } onError: { error in
        expectation.fulfill()
        XCTFail()
      } onCompleted: {
        expectation.fulfill()
      } onDisposed: {
        print("Disposed")
      }.disposed(by: disposeBag)

      wait(for: [expectation], timeout: 10.5)
    }
}
