//
//  testRestaurantUserCases.swift
//  MiniforkTests
//
//  Created by Felipe Fernandes on 16/12/21.
//

import XCTest
@testable import Minifork


class testRestaurantUserCases: XCTestCase {


    func testGetRestaurantListUserCase() throws {

      let configurations = DefaultNetworkConfiguration(baseURL: .url(scheme: "https", host: "alanflament.github.io"))
      let service = DefaultService(configuration: configurations)
      let repository = DefaultRepositoryRestaurantList(service: service)
      let expectation = XCTestExpectation(description: "repository-call-api-restaurant-list")
      
      UserCaseRestaurantGetList(repository: repository) { result in
        switch result {
        case .success(let list):
          XCTAssert(!list.list.isEmpty)
          expectation.fulfill()
        case .failure(_):
          XCTFail()
          expectation.fulfill()
        }
      }.start()

      wait(for: [expectation], timeout: 10.0)

    }
}
