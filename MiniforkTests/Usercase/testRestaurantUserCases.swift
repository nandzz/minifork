//
//  testRestaurantUserCases.swift
//  MiniforkTests
//
//  Created by Felipe Fernandes on 16/12/21.
//

import XCTest

class testRestaurantUserCases: XCTestCase {


    func testGetRestaurantListUserCase() throws {

      let configurations = DefaultNetworkConfiguration(baseURL: .url(scheme: "https", host: "alanflament.github.io"))
      let service = DefaultService(configuration: configurations)
      let repository = DefaultRestaurantRepository(service: service)
      let expectation = XCTestExpectation(description: "repository-call-api-restaurant-list")
      
      UserCaseRestaurantGetList(repository: repository) { result in
        switch result {
        case .success(let list):
          assert(!list.list.isEmpty)
          expectation.fulfill()
        case .failure(_):
          assertionFailure()
          expectation.fulfill()
        }
      }.start()

      wait(for: [expectation], timeout: 10.0)

    }
}
