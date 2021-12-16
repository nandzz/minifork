//
//  Request.swift
//  Minifork
//
//  Created by Felipe Fernandes on 15/12/21.
//

import Foundation

class DefaultNetworkRequest: NetworkRequest {


  public var endPoint: NetworkEndPoint
  public var body: Encodable?
  public var header: [String : String]


  public init(endPoint: NetworkEndPoint, body: Encodable? = nil, header: [String:String]) {
    self.endPoint = endPoint
    self.body = body
    self.header = header
  }

  public func setHeader(request: inout URLRequest) {
    header.forEach { request.setValue($1, forHTTPHeaderField: $0) }
  }

  public func setBody(request: inout URLRequest) throws {
    guard let bodydata = self.body else { throw NetworkTypeError.errorWithMessage("Body request not present")}
    guard let encoded =  bodydata.toJSONData() else {
      throw NetworkTypeError.errorWithMessage("Body not valid")
    }
    request.httpBody = encoded
  }

  public func createRequest(with configuration: NetworkConfiguration) throws -> URLRequest {
    let url = try createURL(with: configuration)
    var request = URLRequest(url: url)
    request.httpMethod = endPoint.method.rawValue
    setHeader(request: &request)
    guard body != nil else { return request }
    try setBody(request: &request)
    return request
  }

  public func createURL(with configuration: NetworkConfiguration) throws -> URL {
    var components = URLComponents()
    guard case .url(let scheme, let host) = configuration.baseURL else {
      throw NetworkTypeError.errorWithMessage("Base URL Wrong or not Present")
    }
    components.scheme = scheme
    components.host = host
    components.path = endPoint.path
    if !endPoint.queries.isEmpty { components.queryItems = endPoint.queries }
    guard let url = components.url else {
      throw NetworkTypeError.errorWithMessage("Url in wrong format, check Path, Host or Scheme")
    }
    return url
  }



}
