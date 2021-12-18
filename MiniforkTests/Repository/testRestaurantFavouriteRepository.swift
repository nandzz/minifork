//
//  testRestaurantFavouriteRepository.swift
//  MiniforkTests
//
//  Created by Felipe Fernandes on 17/12/21.
//

import XCTest
@testable import Minifork

class testRestaurantFavouriteRepository: XCTestCase {


  func testSaveFavouriteRestaurantRepository() throws {
    let repository = RepositoryFactory().makeRestaurantFavouriteRepository()

    let expectation = XCTestExpectation(description: "test-favourite-repository-save")

    repository.saveFavourite(restaurant: RestaurantDTO.mock(uuid: "124")) { result in
      switch result {
      case .success(let restaurant):
        print(restaurant)
        expectation.fulfill()
      case .failure(_):
        XCTFail()
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 10)
  }

  func testRetrieveFavouriteRestaurantListRepository () throws {

    let repository = RepositoryFactory().makeRestaurantFavouriteRepository()

    let expectation = XCTestExpectation(description: "test-favourite-repository-get")

    repository.restoreListOfFavourite { result in
      switch result {
      case .success(_):
        expectation.fulfill()
      case .failure(_):
        XCTFail()
        expectation.fulfill()
      }
    }
  }
}
