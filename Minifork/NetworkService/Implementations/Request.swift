//
//  Request.swift
//  Minifork
//
//  Created by Felipe Fernandes on 15/12/21.
//

import Foundation

public struct DefaultNetworkRequest: NetworkRequest {

  public var endPoint: NetworkEndPoint
  public var body: Decodable?
  public var header: [String : String]


  public init(endPoint: NetworkEndPoint, body: Decodable? = nil, header: [String:String]) {
    self.endPoint = endPoint
    self.body = body
    self.header = header
  }

  public func setHeader() {fatalError()}

  public func setBody() throws {fatalError()}

  public func createRequest() throws -> URLRequest {fatalError()}

  public func createURL() throws -> URL {fatalError()}



}
