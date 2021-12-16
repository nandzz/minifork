//
//  RestaurantServiceInterface.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation


protocol RestaurantService {
  func getRestaurantList(request: NetworkRequest, completion: @escaping ServiceCompletion)
}

// Boundary
extension DefaultNetworkCore: RestaurantService {
  func getRestaurantList(request: NetworkRequest, completion: @escaping ServiceCompletion) {
    send(request: request, completion: completion)
  }
}
