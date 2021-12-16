//
//  ServiceEndPoint.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation



struct ServiceEndPoints {

  static func restaurantList () -> NetworkEndPoint {
    return DefaultServiceEndPoint(path: "/TFTest/test.json", method: .get, queries: [])
  }
}

// Boundary

class DefaultServiceEndPoint: DefaultNetworkEndPoint {}
