//
//  testRestaurantUserCases.swift
//  MiniforkTests
//
//  Created by Felipe Fernandes on 16/12/21.
//

import XCTest
@testable import Minifork
@testable import RxSwift

class testRestaurantUserCases: XCTestCase {


    func testGetRestaurantListUserCase() throws {

      let configurations = DefaultNetworkConfiguration(baseURL: .url(scheme: "https", host: "alanflament.github.io"))
      let service = DefaultService(configuration: configurations)
      let repository = RepositoryFactory().makeRestaurantListRepository()
      let favouriteRepository = RepositoryFactory().makeRestaurantFavouriteRepository()

      let expectation = XCTestExpectation(description: "repository-call-api-restaurant-list")
      let disposeBag = DisposeBag()

      let observable = UserCaseRestaurantGetList(repository: repository, favouriteRepository: favouriteRepository).start()

      observable.subscribe { restaurant in
        print(restaurant)
      } onError: { error in
        XCTFail()
        expectation.fulfill()
      } onCompleted: {
        expectation.fulfill()
        print("completed")
      } onDisposed: {
        print("Disposed")
      }.disposed(by: disposeBag)


      wait(for: [expectation], timeout: 10.0)

    }
}
