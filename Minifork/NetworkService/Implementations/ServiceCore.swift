//
//  Core.swift
//  Minifork
//
//  Created by Felipe Fernandes on 15/12/21.
//

import Foundation


public class DefaultNetworkCore: NetworkService {

  public var session: NetworkSession
  public var logger: NetworkLog
  public var errorResolver: NetworkError
  public var configuration: NetworkConfiguration

  public init(session: NetworkSession = DefaultNetworkSession(),
              logger: NetworkLog = DefaultNetworkLog(),
              error: NetworkError = DefaultNetworkError(),
              configuration: NetworkConfiguration) {
    self.session = session
    self.logger = logger
    self.errorResolver = error
    self.configuration = configuration
  }

  public func send(request: NetworkRequest, completion: @escaping ServiceCompletionOptional) {

    // Explicit because or the request exists or the function does not continue
    // Create request does not return optional
    var networkRequest: URLRequest!

    do {
      networkRequest = try request.createRequest(with: configuration)
    } catch (let error) {
      logger.logError(error: error)
      completion(.failure(NetworkTypeError.errorWithMessage("Request has wrong format")))
      return
    }

    session.request(with: networkRequest) { data, response, error in

      self.logger.logRequest(request: networkRequest)

      if let networkError = error {
        let error = self.errorResolver.resolve(error: networkError)
        self.logger.logError(error: error)
        completion(.failure(error))
        return
      }

      if let httpResponse = response as? HTTPURLResponse, !httpResponse.ok()  {
        let responseError = NetworkTypeError.errorWithCode(httpResponse.statusCode)
        self.logger.logError(error: responseError)
        completion(.failure(responseError))
      }

      self.logger.logReponse(data: data)
//      DispatchQueue.main.async {
        completion(.success(data))
//      }
    }
  }
}
