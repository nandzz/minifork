//
//  Extensions.swift
//  Minifork
//
//  Created by Felipe Fernandes on 15/12/21.
//

import Foundation

extension Data {
    // Source [https://gist.github.com/cprovatas/5c9f51813bc784ef1d7fcbfb89de74fe]
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

extension Encodable {
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}
