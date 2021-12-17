//
//  testRestaurantPictureRepository.swift
//  MiniforkTests
//
//  Created by Felipe Fernandes on 17/12/21.
//

import XCTest
@testable import Minifork

class testRestaurantPictureRepository: XCTestCase {

  var key: DefaultCacheKey!

  override func setUpWithError() throws {
    self.key = DefaultCacheKey(url: "https://res.cloudinary.com/tf-lab/image/upload/f_auto,q_auto,w_480,h_270/restaurant/b1d8f006-2477-4715-b937-2c34d616dccb/68e364a6-e903-4fb1-9e1e-d91d97457266.jpg")
  }

  func testBasicPictureRequest() throws {
    let repository = RepositoryFactory().makePictureRepository()
    let expectation = XCTestExpectation(description: "repository-getImage-test")

    repository.getPicture(key: key) { result in
      switch result {
      case .success(let data):
        print(data)
        expectation.fulfill()
      case .failure(let error):
        print(error)
        assertionFailure()
        expectation.fulfill()
      }
    } fromCache: { result in
      assertionFailure("Cache should't work")
    }

    wait(for: [expectation], timeout: 10.5)
  }


  func testPictureRequestWithCacheSaving () {
    let repository = RepositoryFactory().makePictureRepository()
    let expectation = XCTestExpectation(description: "repository-request-savecache-test")

    repository.getPicture(key: self.key) { result in
      switch result {
        case .success(_):
        repository.getPicture(key: self.key) { result in
          XCTFail()
          expectation.fulfill()
        } fromCache: { result in
          expectation.fulfill()
        }
        case .failure(let error):
          print(error)
          expectation.fulfill()
          assertionFailure()
        }
    } fromCache: { result in
      expectation.fulfill()
      XCTFail()
    }

    wait(for: [expectation], timeout: 10.0)
  }
}
