//
//  ServiceRequests + EndPoints.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation


class DefaultServiceRequest: DefaultNetworkRequest {}

struct ServiceRequests {

  // Here you can also pass parameters to the helper functions
  static func restaurantList (endPoint: NetworkEndPoint) -> NetworkRequest {
    return DefaultServiceRequest(endPoint: endPoint, body: nil, header: [:])
  }
}
