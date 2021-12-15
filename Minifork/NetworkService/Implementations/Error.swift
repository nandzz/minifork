//
//  Error.swift
//  Minifork
//
//  Created by Felipe Fernandes on 15/12/21.
//

import Foundation


public struct DefaultNetworkError: NetworkError {

  public init() {}
  
  func resolve(error: Error) -> Error {
    fatalError()
  }
}
