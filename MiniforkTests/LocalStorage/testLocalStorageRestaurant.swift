//
//  testLocalStorage.swift
//  MiniforkTests
//
//  Created by Felipe Fernandes on 17/12/21.
//

import XCTest
@testable import Minifork

class testLocalStorage: XCTestCase {


  var uuid: UUID = UUID()

  func testRestaurantLocalStorageCycle () throws {

    let storage = DefaultStorageRestaurantFavourite()
    let mockData = RestaurantDTO.mock(uuid: self.uuid.uuidString)
    var expectation = self.expectation(description: "tes-storage-basic-save")

    storage.saveFavouriteRestaurant(restautant: mockData) { result in
      switch result {
      case .success(_):
        expectation.fulfill()
      case .failure(let error):
        print(error)
        expectation.fulfill()
        assertionFailure()
      }
    }

    waitForExpectations(timeout: 6.0) { error in

      expectation = self.expectation(description: "test-storage-basic-get")

      storage.getFavouriteRestaurantList { result in
        switch result {
        case .success(let list):
          print(list)
          expectation.fulfill()
        case .failure(let error):
          print(error)
          assertionFailure()
          expectation.fulfill()
        }
      }

      self.waitForExpectations(timeout: 5.0) { error in
        expectation = self.expectation(description: "test-storage-basic-remove")

        storage.removeFavouriteRestaurant(uuid: self.uuid.uuidString) { result in
          switch result {
          case .success(_):
            expectation.fulfill()
          case .failure(let error):
            print(error)
            expectation.fulfill()
            assertionFailure()
          }
        }

        self.waitForExpectations(timeout: 5.0) { error in
          expectation = self.expectation(description: "test-storage-basic-get")

          storage.getFavouriteRestaurantList { result in
            switch result {
            case .success(let list):
              print(list)
              expectation.fulfill()
            case .failure(let error):
              print(error)
              assertionFailure()
              expectation.fulfill()
            }
          }

          self.waitForExpectations(timeout: 5.0, handler: nil)

        }

      }
    }
  }


  func testSaveRestaurantToLocalStorage() throws {

    let storage = DefaultStorageRestaurantFavourite()
    let mockData = RestaurantDTO.mock(uuid: "123")
    let expectation = XCTestExpectation(description: "test-storage-basic-save")

    storage.saveFavouriteRestaurant(restautant: mockData) { result in
      switch result {
      case .success(_):
        expectation.fulfill()
      case .failure(let error):
        print(error)
        assertionFailure()
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 10.0)
  }


  func testgetListRestaurantFromLocalStorage() throws {
    let storage = DefaultStorageRestaurantFavourite()
    let expectation = XCTestExpectation(description: "test-storage-basic-get")

    storage.getFavouriteRestaurantList { result in
      switch result {
      case .success(let list):
        print(list)
        expectation.fulfill()
      case .failure(let error):
        print(error)
        assertionFailure()
        expectation.fulfill()
      }
    }

    wait(for: [expectation], timeout: 5.0)

  }

  func testRemoveRestaurantFromLocalStorage () throws {

    let storage = DefaultStorageRestaurantFavourite()
    let uuid: String = "123"

    let expectation = XCTestExpectation(description: "test-storage-basic-delete")

    storage.removeFavouriteRestaurant(uuid: uuid) { result in
      switch result {
      case .success(_):
        expectation.fulfill()
      case .failure(let error):
        print(error)
        expectation.fulfill()
        assertionFailure()
      }
    }
    wait(for: [expectation], timeout: 3.0)
  }

}
