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
 public var error: NetworkError
 public var configuration: NetworkConfiguration

  public init(session: NetworkSession = DefaultNetworkSession(),
              logger: NetworkLog = DefaultNetworkLog(),
              error: NetworkError = DefaultNetworkError(),
              configuration: NetworkConfiguration) {
    self.session = session
    self.logger = logger
    self.error = error
    self.configuration = configuration
  }

  public func send(request: URLRequest, response: @escaping NetworkCompletion) {
    fatalError()
  }
}
