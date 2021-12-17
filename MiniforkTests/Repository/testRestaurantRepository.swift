//
//  testRestaurantRepository.swift
//  MiniforkTests
//
//  Created by Felipe Fernandes on 16/12/21.
//

import XCTest
@testable import Minifork


class testRestaurantRepository: XCTestCase {

    func testRestaurantRepositoryGetList() throws {

      let repository = RepositoryFactory().makeRestaurantListRepository()

      let expectation = XCTestExpectation(description: "repository-call-api-restaurant-list")

      repository.getRestaurantList { result in
        switch result {
        case .success(let restaurantDTO):
          print(restaurantDTO as Any)
          expectation.fulfill()
        case .failure(let error):
          print(error)
          XCTFail()
          expectation.fulfill()
        }
      }
      wait(for: [expectation], timeout: 10.0)
    }
}
