//
//  Session.swift
//  Minifork
//
//  Created by Felipe Fernandes on 15/12/21.
//

import Foundation


public class DefaultNetworkSession: NetworkSession {

  public init() {}

  public var session: URLSession = URLSession.shared

  public func request(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
    let task = session.dataTask(with: request, completionHandler: completion)
    task.resume()
  }
}
