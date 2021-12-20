//
//  testRestaurantPictureRepository.swift
//  MiniforkTests
//
//  Created by Felipe Fernandes on 17/12/21.
//

import XCTest
@testable import Minifork

class testRestaurantPictureRepository: XCTestCase {

  var restaurant: RestaurantDTO!

  override func setUpWithError() throws {
    self.restaurant = RestaurantDTO.mockWithPictureURL(uuid: "123", url: "https://res.cloudinary.com/tf-lab/image/upload/f_auto,q_auto,w_480,h_270/restaurant/3da6a3db-1080-4e1e-8438-1e82ca838100/ff083b11-2a3a-4b4c-8e92-21ef2afe712a.jpg")
  }

  func testBasicPictureRequest() throws {
    let repository = RepositoryFactory().makePictureRepository()
    let expectation = XCTestExpectation(description: "repository-getImage-test")

    repository.getPicture(restaurant: restaurant) { result in
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

    repository.getPicture(restaurant: self.restaurant) { result in
      switch result {
      case .success(_):
        repository.getPicture(restaurant: self.restaurant) { result in
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
