//
//  Error.swift
//  Minifork
//
//  Created by Felipe Fernandes on 15/12/21.
//

import Foundation


public struct DefaultNetworkError: NetworkError {

  public init() {}
  
  public func resolve(error: Error) -> Error {
    if let networkError = error as? URLError {
      switch networkError.code {
      case .notConnectedToInternet:
        return NetworkTypeError.noInternetConnection
      case .cannotFindHost:
        return NetworkTypeError.errorWithMessage("Wrong Host")
      case .networkConnectionLost:
        return NetworkTypeError.errorWithMessage("Connection Lost")
      default:
        return NetworkTypeError.genericError(networkError)
      }
    }
    return error
  }
}
