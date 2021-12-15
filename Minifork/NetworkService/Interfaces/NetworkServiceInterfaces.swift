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
}

public protocol NetworkSession {
  var session: URLSession { get }
  func request(with request: URLRequest, completion: NetworkCompletion)
}

public protocol NetworkConfiguration {
    var baseURL: BaseUrl { get }
}

public protocol NetworkLog {
  func logError   (request: URLRequest)
  func logReponse (data: Data)
  func logRequest ()
}

public enum BaseUrl {
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

  func createURL()
}

public protocol NetworkRequest {
  var endPoint: NetworkEndPoint { get }
  var body: Decodable { get }
  var header:  [String:String] { get }

  func setHeader()
  func setBody()
  func createRequest()
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







