//
//  CacheStorageInterfaces.swift
//  Minifork
//
//  Created by Felipe Fernandes on 17/12/21.
//

import Foundation


protocol CacheItem: Hashable {
  var identifier: String { get }
  var data: Data { get }
  var name: String { get }
}

protocol CacheKey: Hashable {
  var uuid: String { get }
}

protocol CacheDataStorage {

  associatedtype cacheItem
  associatedtype cacheKey

  var cache: NSCache<DefaultCacheKey, DefaultCacheItem> { get }

  func save(key: cacheKey, item: cacheItem) -> Bool
  func delete(key: cacheKey) -> Bool
  func retrieve(key: cacheKey) -> cacheItem?
}
