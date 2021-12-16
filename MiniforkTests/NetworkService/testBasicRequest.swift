//
//  testBasicRequest.swift
//  MiniforkTests
//
//  Created by Felipe Fernandes on 16/12/21.
//

import XCTest
import Minifork

class testBasicRequest: XCTestCase {


  func testRequestContructor () throws  {
    let endPoint = DefaultNetworkEndPoint(path: "TFTest/test.json", method: .get, queries: [])
    let configuration = DefaultNetworkConfiguration(baseURL: .url(scheme: "https", host: "alanflament.github.io"))
    let request = DefaultNetworkRequest(endPoint: endPoint, body: nil, header: [:])
    let networkRequest = request.createRequest(with: configuration)

    XCTAssert(networkRequest.allHTTPHeaderFields?.contains(where: {
      $0.key == "
    }))
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
        assertionFailure()
        expectation.fulfill()
      }
    }

    wait(for: [expectation], timeout: 10.0)

  }

}
