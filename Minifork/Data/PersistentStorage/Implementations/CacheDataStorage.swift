//
//  CacheDataStorage.swift
//  Minifork
//
//  Created by Felipe Fernandes on 17/12/21.
//

import Foundation


class DefaultCacheKey: CacheKey {

  var uuid: String

  init(uuid: String) {
    self.uuid = uuid
  }

  static func == (lhs: DefaultCacheKey, rhs: DefaultCacheKey) -> Bool {
    return lhs.uuid == rhs.uuid
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(uuid)
  }

}

class DefaultCacheItem: CacheItem {

  var identifier: String
  var data: Data
  var name: String


  init(data: Data, name: String, uuid: String) {
    self.identifier = uuid
    self.data = data
    self.name = name
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
    self.cache.setObject(item, forKey: key)
    return true
  }

  @discardableResult
  func delete(key: DefaultCacheKey) -> Bool {
    if (self.cache.object(forKey: key) != nil) {
      self.cache.removeObject(forKey: key)
      return true
    } else {
      return false
    }

  }

  func retrieve(key: DefaultCacheKey) -> DefaultCacheItem? {
    guard let obj = self.cache.object(forKey: key) else {
      assertionFailure()
      return nil
    }
    return obj
  }
}

