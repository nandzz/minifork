//
//  testCacheStorage.swift
//  MiniforkTests
//
//  Created by Felipe Fernandes on 17/12/21.
//

import XCTest
@testable import Minifork

class testCacheStorage: XCTestCase {

    var sutcache: DefaultCacheStorage!
    var sutobj: DefaultCacheItem!
    var sutkey: DefaultCacheKey!

    override func setUpWithError() throws {
      self.sutcache = DefaultCacheStorage(cache: NSCache<DefaultCacheKey, DefaultCacheItem>())
      self.sutobj = DefaultCacheItem(data: Data(), name: "TestCash", uuid: "testuuid")
      self.sutkey = DefaultCacheKey(uuid: UUID().uuidString)
    }

    override func tearDownWithError() throws {
        sutcache = nil
        sutobj = nil
        sutkey = nil 
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
