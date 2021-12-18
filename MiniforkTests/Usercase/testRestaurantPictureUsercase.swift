//
//  testRestaurantPictureUsercase.swift
//  MiniforkTests
//
//  Created by Felipe Fernandes on 18/12/21.
//

import XCTest
@testable import Minifork

class testRestaurantPictureUsercase: XCTestCase {

    func testRestaurantGetPictureUsercase() throws {
      let repository = RepositoryFactory().makePictureRepository()
      let key = DefaultCacheKey(url: "https://res.cloudinary.com/tf-lab/image/upload/f_auto,q_auto,w_480,h_270/restaurant/b1d8f006-2477-4715-b937-2c34d616dccb/68e364a6-e903-4fb1-9e1e-d91d97457266.jpg")
      let expectation = XCTestExpectation(description: "test-getpicture-usercase")

      UsercaseGetPicture(repository: repository, key: key) { result in
        switch result {
        case .success(let data):
          print(data)
          expectation.fulfill()
        case .failure(let error):
          print(error)
          expectation.fulfill()
          XCTFail()
        }
      }.start()
      wait(for: [expectation], timeout: 10.5)
    }
}
