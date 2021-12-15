//
//  Log.swift
//  Minifork
//
//  Created by Felipe Fernandes on 15/12/21.
//

import Foundation


public struct DefaultNetworkLog: NetworkLog {

  public func logError(request: URLRequest) {}
  public func logReponse(data: Data) {}
  public func logRequest() {}

  public init() {}

}
