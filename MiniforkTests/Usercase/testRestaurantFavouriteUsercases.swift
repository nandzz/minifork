//
//  testRestaurantFavouriteUsercases.swift
//  MiniforkTests
//
//  Created by Felipe Fernandes on 18/12/21.
//

import XCTest
@testable import Minifork
@testable import RxSwift


class testRestaurantFavouriteUsercases: XCTestCase {


  var disposableBag: DisposeBag!

  override func setUpWithError() throws {
    self.disposableBag = DisposeBag()
  }

  override func tearDownWithError() throws {
    self.disposableBag = nil
  }


  func testSavingFavouriteRestaurantUserCase() throws {
    let repository = RepositoryFactory().makeRestaurantFavouriteRepository()
    let expectation = XCTestExpectation(description: "save-restaurant-usercase-test")
    let saveUsercase = UserCaseSaveFavouriteRestaurant(repository, Restaurant.mock(uuid: UUID().uuidString))
    let saveObserver = saveUsercase.start()

    saveObserver.subscribe { element in
      print(element)
    } onError: { error in
      print(error)
      expectation.fulfill()
      XCTFail()
    } onCompleted: {
      expectation.fulfill()
    } onDisposed: {
      print("Disposed")
    }.disposed(by: disposableBag)

    wait(for: [expectation], timeout: 10.0)
  }


  func testGetListOfFavouriteUserCase () throws {
    let repository = RepositoryFactory().makeRestaurantFavouriteRepository()
    let expectation = XCTestExpectation(description: "get-restaurant-usercase-test")
    let restaurant = Restaurant.mock(uuid: "123")

    let saveUsercase = UserCaseSaveFavouriteRestaurant(repository, restaurant)
    let getObserver = UserCaseGetFavouriteRestaurantList(repository)

    let saveObserve = saveUsercase.start()
    let getObserve = getObserver.start()


    saveObserve.subscribe { restaurant in
      print(restaurant)
    } onError: { error in
      expectation.fulfill()
      XCTFail()
    } onCompleted: { [self] in

      getObserve.subscribe { objc in
        guard let list = objc as? RestaurantList else {
          XCTFail()
          return
        }
        print(list)
        XCTAssert(!list.list.isEmpty)
      } onError: { error in
        expectation.fulfill()
        XCTFail()
      } onCompleted: {
        expectation.fulfill()
      } onDisposed: {
        print("Disposed")
      }.disposed(by: disposableBag)


    } onDisposed: {
      print("Disposed")
    }.disposed(by: disposableBag)

  }

  func testRemoveRestaurantFromFavouriteUserCase () throws {
    let repository = RepositoryFactory().makeRestaurantFavouriteRepository()
    let expectation = XCTestExpectation(description: "remove-restaurant-usercase-test")
    let restaurant = Restaurant.mock(uuid: UUID().uuidString)

    let saveUserCase = UserCaseSaveFavouriteRestaurant(repository, restaurant)
    let removeUserCase = UserCaseRemoveFavouriteRestaurant(repository, restaurant)
    let getObserver = UserCaseGetFavouriteRestaurantList(repository).start()

    let saveObserver = saveUserCase.start()
    let removeObserver = removeUserCase.start()


    saveObserver.subscribe { restaurant in
      print(restaurant)
    } onError: { error in
      expectation.fulfill()
      XCTFail()
    } onCompleted: { [self] in

      removeObserver.subscribe { _ in

      } onError: { error in
        expectation.fulfill()
        XCTFail()
      } onCompleted: {

        getObserver.subscribe { objc in
          guard let list = objc as? RestaurantList else {
            XCTFail()
            return
          }
          XCTAssert(!list.list.contains(where: {$0.uuid == restaurant.uuid}))
          expectation.fulfill()
        } onError: { error in
          print(error)
          expectation.fulfill()
          XCTFail()
        } onCompleted: {
          expectation.fulfill()
        } onDisposed: {
          print("Disposed")
        }.disposed(by: self.disposableBag)

      } onDisposed: {
        print("Disposed")
      }.disposed(by: disposableBag)

    } onDisposed: {
      print("Disposed")
    }.disposed(by: disposableBag)

  }
}
