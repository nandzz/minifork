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

    let observer = UserCaseSaveFavouriteRestaurant(repository: repository, restaurant: Restaurant.mock(uuid: UUID().uuidString)).start()

    observer.subscribe { element in
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


    let saveObserve = UserCaseSaveFavouriteRestaurant(repository: repository, restaurant: restaurant).start()
    let getObserve = UserCaseGetFavouriteRestaurantList(repository: repository, restaurant: restaurant).start()


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

    let saveObserve = UserCaseSaveFavouriteRestaurant(repository: repository, restaurant: restaurant).start()
    let removeObserve = UserCaseRemoveFavouriteRestaurant(repository: repository, restaurant: restaurant).start()
    let getObserve = UserCaseGetFavouriteRestaurantList(repository: repository, restaurant: restaurant).start()

    saveObserve.subscribe { restaurant in
      print(restaurant)
    } onError: { error in
      expectation.fulfill()
      XCTFail()
    } onCompleted: { [self] in

      removeObserve.subscribe { _ in

      } onError: { error in
        expectation.fulfill()
        XCTFail()
      } onCompleted: {

        getObserve.subscribe { list in
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
