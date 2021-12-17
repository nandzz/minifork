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

  static func restaurantPicture (url: String) throws -> NetworkEndPoint {
    guard let url = URL(string: url) else {
      assertionFailure("URL with wrong format")
      throw NetworkTypeError.errorWithMessage("URL with wrong Format")
    }
    let path = url.path
    return DefaultServiceEndPoint(path: path, method: .get, queries: [])
  }
}

// Boundary

class DefaultServiceEndPoint: DefaultNetworkEndPoint {}
