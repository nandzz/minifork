//
//  RepositoryPicture.swift
//  Minifork
//
//  Created by Felipe Fernandes on 17/12/21.
//

import Foundation


class DefaultRepositoryPicture: RepositoryPicture {

  
  var service: PictureService?
  let cache: DefaultCacheStorage
  
  init(_ cache: DefaultCacheStorage) {
    self.cache = cache
  }

  func getPicture(key: DefaultCacheKey, fromService: @escaping RepositoryCompletionResponse<Data>, fromCache: @escaping RepositoryCompletionResponse<Data>) {

//    DispatchQueue.global(qos: .background).async {
      //First check in the cache
      print(key.hashValue)
      if let cachedData = self.cache.retrieve(key: key) {
        print("Object \(cachedData) Retrieved from cache")
        DispatchQueue.main.async {
          fromCache(.success(cachedData.data))
        }
        return
      }
      // Here the service needs to change for each request
      // hence, the url scheme and host can be different for any request
      var endPoint: NetworkEndPoint

      do {
        try self.changeServiceDynamically(url: key.url)
        endPoint = try ServiceEndPoints.restaurantPicture(url: key.url)
      } catch (let error) {
        fromService(.failure(error))
        return
      }

      let request = ServiceRequests.restaurantPicture(endPoint: endPoint)
      self.service?.getPicture(request: request, completion: { result in
        switch result {
        case .success(let data):
          self.cache.save(key: key,
                          item: DefaultCacheItem(data: data))
          DispatchQueue.main.async {
            fromService(.success(data))
          }

        case .failure(let error):
          fromService(.failure(error))
        }
      })
//    }
  }
  
  private func changeServiceDynamically(url: String) throws {
    service = try ServicesFactory().createRestaurantPictureService(url: url)
  }
}
