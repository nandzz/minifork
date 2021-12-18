//
//  testRestaurantFavouriteUsercases.swift
//  MiniforkTests
//
//  Created by Felipe Fernandes on 18/12/21.
//

import XCTest
@testable import Minifork

class testRestaurantFavouriteUsercases: XCTestCase {


  func testSavingFavouriteRestaurantUserCase() throws {
    let repository = RepositoryFactory().makeRestaurantFavouriteRepository()
    let expectation = XCTestExpectation(description: "save-restaurant-usercase-test")

    UserCaseSaveFavouriteRestaurant(repository: repository, restaurant: Restaurant.mock(uuid: "123")) { result in
      switch result {
      case .success(let restaurant):
        print(restaurant)
        expectation.fulfill()
      case .failure(let error):
        print(error)
        expectation.fulfill()
        XCTFail()
      }
    }.start()

    wait(for: [expectation], timeout: 10.0)
  }


  func testGetListOfFavouriteUserCase () throws {
    let repository = RepositoryFactory().makeRestaurantFavouriteRepository()
    let expectation = XCTestExpectation(description: "get-restaurant-usercase-test")
    let restaurant = Restaurant.mock(uuid: "123")

    UserCaseSaveFavouriteRestaurant(repository: repository, restaurant: restaurant) { result in
      switch result {
      case .success(_):
        UserCaseGetFavouriteRestaurantList(repository: repository, restaurant: restaurant) { innerResult in
          switch innerResult {
          case .success(let obj):
            print(obj.list)
            XCTAssert(!obj.list.isEmpty)
            expectation.fulfill()
          case .failure(let error):
            print(error)
            expectation.fulfill()
            XCTFail()
          }
        }.start()
      case .failure(let error):
        print(error)
        expectation.fulfill()
        XCTFail()
      }
    }.start()
  }

  func testRemoveRestaurantFromFavouriteUserCase () throws {
    let repository = RepositoryFactory().makeRestaurantFavouriteRepository()
    let expectation = XCTestExpectation(description: "remove-restaurant-usercase-test")
    let restaurant = Restaurant.mock(uuid: UUID().uuidString)
    
    UserCaseSaveFavouriteRestaurant(repository: repository, restaurant: restaurant) { saveResult in
      switch saveResult {
      case .success(_):
        UserCaseRemoveFavouriteRestaurant(repository: repository, restaurant: restaurant) { deleteResult in
          switch deleteResult {
          case .success(_):
            UserCaseGetFavouriteRestaurantList(repository: repository, restaurant: restaurant) { getResult in
              switch getResult {
              case .success(let list):
                XCTAssert(!list.list.contains(where: {$0.uuid == restaurant.uuid}))
                expectation.fulfill()
              case .failure(let error):
                print(error)
                expectation.fulfill()
                XCTFail()
              }
            }.start()
          case .failure(let error):
            print(error)
            expectation.fulfill()
            XCTFail()
          }
        }.start()
      case .failure(let error):
        print(error)
        expectation.fulfill()
        XCTFail()
      }
    }.start()
    wait(for: [expectation], timeout: 10.0)
  }
}
