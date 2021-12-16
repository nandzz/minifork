//
//  ServiceEndPoint.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation


class DefaultServiceEndPoint: DefaultNetworkEndPoint {}

struct ServiceEndPoints {

  static func restaurantList () -> NetworkEndPoint {
    return DefaultServiceEndPoint(path: "/TFTest/test.json", method: .get, queries: [])
  }
}
