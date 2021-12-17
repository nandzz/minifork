//
//  testBasicRequest.swift
//  MiniforkTests
//
//  Created by Felipe Fernandes on 16/12/21.
//

import XCTest
import Minifork
@testable import Minifork


class testBasicRequest: XCTestCase {


  func testRequestContructor () throws  {

    struct TestEcodable: Encodable {
        let test: String
    }

    let testObj = TestEcodable(test: "hello")


    let endPoint = DefaultNetworkEndPoint(path: "/TFTest/test.json", method: .get, queries: [])
    let configuration = DefaultNetworkConfiguration(baseURL: .url(scheme: "https", host: "alanflament.github.io"))
    let request = DefaultNetworkRequest(endPoint: endPoint, body: testObj, header: ["Content-Language": "en"]
                                                                               )
    let networkRequest = try? request.createRequest(with: configuration)

    XCTAssert((networkRequest != nil))

    XCTAssert(((networkRequest?.allHTTPHeaderFields?.contains(where: {
      $0.key == "Content-Language"
    })) != nil))

    XCTAssert((networkRequest?.httpBody != nil))

  }


  func testBasicAPIRequest() throws {

    let configuration = DefaultNetworkConfiguration(baseURL: .url(scheme: "https", host: "alanflament.github.io"))
    let manager = DefaultNetworkCore(configuration: configuration)

    let endPoint = DefaultNetworkEndPoint(path: "/TFTest/test.json", method: .get, queries: [])
    let request = DefaultNetworkRequest(endPoint: endPoint, body: nil, header: [:])

    let expectation = XCTestExpectation(description: "api-basic-call-test")


    manager.send(request: request) {
      switch $0 {
      case .success(_):
        expectation.fulfill()
      case .failure(_):
        XCTFail()
        expectation.fulfill()
      }
    }

    wait(for: [expectation], timeout: 10.0)

  }

}
