//
//  Log.swift
//  Minifork
//
//  Created by Felipe Fernandes on 15/12/21.
//

import Foundation


public struct DefaultNetworkLog: NetworkLog {


  public func logRequest(request: URLRequest) {
    print("""
                 ✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺
                                ✺ Request Started ✺
              """, terminator: "\n\n\n\n")

        guard let endPoint = request.url else { return }
        guard let method = request.httpMethod else { return }

        print("""
                 EndPoint: \(endPoint)
                 Method: \(method)
                 Time: \(Date()) \n\n
                 ✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺
              """)

  }


  public func logError(error: Error) {
    print("""
                ===========================================================
                                ✺ Request Error ✺
              """, terminator: "\n\n\n\n")

        print("  \(error)")

        print("""
                ✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺
                                ✺ Request Ended ✺
              """)



  }
  public func logReponse(data: Data?) {
    print("""
                ===========================================================
                                ✺ Request Reponse ✺
              """, terminator: "\n\n\n\n")

    print(data?.prettyPrintedJSONString as Any)

    print("""
                ✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺✺
                                ✺ Request Ended ✺
          """)
  }


  public init() {}

}
