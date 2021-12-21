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
      let restaurant = Restaurant.mock(uuid: "Some")
      let expectation = XCTestExpectation(description: "test-getpicture-usercase")
      let disposeBag = DisposeBag()
      let getUsercase =  DefaultUserCaseGetImage(repository)
      let observable = getUsercase.start(restaurant)

      observable.subscribe { data in
        print(data)
      } onError: { error in
        print(error)
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
