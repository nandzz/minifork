//
//  testRestaurantRepository.swift
//  MiniforkTests
//
//  Created by Felipe Fernandes on 16/12/21.
//

import XCTest

class testRestaurantRepository: XCTestCase {

    func testRestaurantRepositoryGetList() throws {

      let configurations = DefaultNetworkConfiguration(baseURL: .url(scheme: "https", host: "alanflament.github.io"))
      let service = DefaultService(configuration: configurations)
      let repository = DefaultRepositoryRestaurantList(service: service)

      let expectation = XCTestExpectation(description: "repository-call-api-restaurant-list")

      repository.getRestaurantList { result in
        switch result {
        case .success(let restaurantDTO):
          print(restaurantDTO as Any)
          expectation.fulfill()
        case .failure(let error):
          print(error)
          assertionFailure()
          expectation.fulfill()
        }
      }
      wait(for: [expectation], timeout: 10.0)
    }
}
