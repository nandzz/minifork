//
//  CacheDataStorage.swift
//  Minifork
//
//  Created by Felipe Fernandes on 17/12/21.
//

import Foundation


class DefaultCacheKey: CacheKey, Decodable {

  var url: String

  init(url: String) {
    self.url = url
  }

  static func == (lhs: DefaultCacheKey, rhs: DefaultCacheKey) -> Bool {
    return lhs.url == rhs.url
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(url)
  }
}

class DefaultCacheItem: CacheItem {

  var identifier: UUID = UUID()
  var data: Data

  init(data: Data) {
    self.identifier = UUID()
    self.data = data
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }

  static func == (lhs: DefaultCacheItem, rhs: DefaultCacheItem) -> Bool {
    return lhs.identifier == rhs.identifier
  }

}
class DefaultCacheStorage: CacheDataStorage {

  typealias cacheItem = DefaultCacheItem
  typealias cacheKey = DefaultCacheKey

  var cache: NSCache<DefaultCacheKey, DefaultCacheItem>

  init(cache: NSCache<DefaultCacheKey, DefaultCacheItem>) {
    self.cache = cache
  }

  @discardableResult
  func save(key: DefaultCacheKey, item: DefaultCacheItem) -> Bool {
    print("Saving in Cache")
    self.cache.setObject(item, forKey: key)
    return true
  }

  @discardableResult
  func delete(key: DefaultCacheKey) -> Bool {
    if (self.cache.object(forKey: key) != nil) {
      print("Deleting from Cache")
      self.cache.removeObject(forKey: key)
      return true
    } else {
      return false
    }

  }

  func retrieve(key: DefaultCacheKey) -> DefaultCacheItem? {
    print("Retrieving from Cache")
    if let all = self.cache.value(forKey: "allObjects") as? NSArray {
      for object in all {
        print("object is \(object)")
      }
    }
    return self.cache.object(forKey: key)
  }
}

