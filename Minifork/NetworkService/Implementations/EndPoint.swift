//
//  EndPoint.swift
//  Minifork
//
//  Created by Felipe Fernandes on 15/12/21.
//

import Foundation

public class DefaultNetworkEndPoint: NetworkEndPoint {
  public var path: String
  public var method: HttpMethods
  public var queries: [URLQueryItem]

  public init(path: String,
              method: HttpMethods,
              queries: [URLQueryItem]) {
    self.queries = queries
    self.path = path
    self.method = method
  }
}
