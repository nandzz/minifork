//
//  RestaurantServiceInterface.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation


protocol RestaurantService {
  func getRestaurantList(request: NetworkRequest, completion: @escaping ServiceCompletionOptional)
}

protocol PictureService {
  func getPicture(request: NetworkRequest, completion: @escaping ServiceCompletion)
}

// Boundary

class DefaultService: DefaultNetworkCore {}


extension DefaultService: RestaurantService {
  func getRestaurantList(request: NetworkRequest, completion: @escaping ServiceCompletionOptional) {
    send(request: request, completion: completion)
  }
}

extension DefaultService: PictureService {
  func getPicture(request: NetworkRequest, completion: @escaping ServiceCompletion) {
    send(request: request) { result in
      switch result {
      case .success(let data):
        guard let dataResponse = data else {
          completion(.failure(NetworkTypeError.ErrorWaitingDataButNotPresent))
          return
        }
        completion(.success(dataResponse))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
