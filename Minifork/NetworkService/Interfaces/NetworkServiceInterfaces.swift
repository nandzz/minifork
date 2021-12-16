//
//  Interfaces.swift
//  Minifork
//
//  Created by Felipe Fernandes on 15/12/21.
//

import Foundation

public protocol NetworkService {
    var session: NetworkSession { get }
    var logger: NetworkLog { get }
    var error: NetworkError { get }
    var configuration: NetworkConfiguration { get }

    func send(request: URLRequest, response: @escaping NetworkCompletion)
}

public protocol NetworkSession {
  var session: URLSession { get }
  func request(with request: URLRequest, completion: @escaping NetworkCompletion)
}

public protocol NetworkConfiguration {
    var baseURL: NetworkBaseURL { get }
}

public protocol NetworkLog {
  func logError   (error: Error)
  func logReponse (data: Data)
  func logRequest (request: URLRequest)
}

public enum NetworkBaseURL {
  case url(scheme: String, host: String)
}

public enum HttpMethods: String {
    case post = "POST"
    case get = "GET"
}

public protocol NetworkEndPoint  {
  var path: String { get }
  var method: HttpMethods { get }
  var queries: [URLQueryItem] { get }


}

public protocol NetworkRequest {
  var endPoint: NetworkEndPoint { get }
  var body: Encodable? { get }
  var header:  [String:String] { get }

  func setHeader(request: inout URLRequest)
  func setBody(request: inout URLRequest) throws
  func createRequest(with configuration: NetworkConfiguration) throws -> URLRequest
  func createURL(with configuration: NetworkConfiguration) throws -> URL
}

public protocol NetworkError {
    func resolve(error: Error) -> Error
}

public enum NetworkTypeError: Error {
  case genericError(Error)
  case notFound(Error)
  case errorWithMessage(String)
  case errorWithCode(Int)
  case noInternetConnection
}







