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
    let saveUsercase = DefaultUserCaseSaveFavouriteRestaurant(repository)
    let saveObserver = saveUsercase.start(Restaurant.mock(uuid: UUID().uuidString))

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

    let saveUsercase = DefaultUserCaseSaveFavouriteRestaurant(repository)
    let getObserver = DefaultUserCaseGetFavouriteRestaurantList(repository)

    let saveObserve = saveUsercase.start(restaurant)
    let getObserve = getObserver.start()


    saveObserve.subscribe { restaurant in
      print(restaurant)
    } onError: { error in
      expectation.fulfill()
      XCTFail()
    } onCompleted: { [self] in

      getObserve.subscribe { list in
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

    let save = DefaultUserCaseSaveFavouriteRestaurant(repository).start(restaurant)
    let remove = DefaultUserCaseRemoveFavouriteRestaurant(repository).start(restaurant)
    let get = DefaultUserCaseGetFavouriteRestaurantList(repository).start()


    save.subscribe { restaurant in
      print(restaurant)
    } onError: { error in
      expectation.fulfill()
      XCTFail()
    } onCompleted: { [self] in

      remove.subscribe { _ in

      } onError: { error in
        expectation.fulfill()
        XCTFail()
      } onCompleted: {

        get.subscribe { list in
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
