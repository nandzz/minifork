//
//  Configuration.swift
//  Minifork
//
//  Created by Felipe Fernandes on 15/12/21.
//

import Foundation

public class DefaultNetworkConfiguration: NetworkConfiguration {
  public var baseURL: NetworkBaseURL

  public init (baseURL: NetworkBaseURL) {
    self.baseURL = baseURL
  }
}
