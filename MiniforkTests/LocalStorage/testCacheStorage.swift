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
    self.sutobj = DefaultCacheItem(data: Data())
    self.sutkey = DefaultCacheKey(uuid: UUID())
  }

  override func tearDownWithError() throws {
    sutcache = nil
    sutobj = nil
    sutkey = nil
  }

  func testCacheInsertion() throws {
    sutcache.save(key: sutkey, item: sutobj)
  }

  func testCacheDeletion () throws {
    sutcache.save(key: sutkey, item: sutobj)
    sutcache.delete(key: sutkey)
    let result = sutcache.retrieve(key: sutkey)
    XCTAssert(result == nil)
  }

  func testCacheRetrieve() throws {
    sutcache.save(key: sutkey, item: sutobj)
    let result = sutcache.retrieve(key: sutkey)
    print(result?.data as Any)
    XCTAssert(result != nil)
  }

  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      sutcache.save(key: sutkey, item: sutobj)
      sutcache.delete(key: sutkey)
      // Funny
    }
  }

}
