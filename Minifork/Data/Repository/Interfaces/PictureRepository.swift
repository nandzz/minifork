//
//  PictureRepository.swift
//  Minifork
//
//  Created by Felipe Fernandes on 17/12/21.
//

import Foundation

protocol RepositoryPicture {

  var cache: DefaultCacheStorage { get }
  var service: PictureService? { get set }

  func getPicture(restaurant: RestaurantDTO, fromService: @escaping RepositoryCompletionResponse<Data>, fromCache: @escaping RepositoryCompletionResponse<Data>)

}
