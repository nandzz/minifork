//
//  EncodeDecode.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation

struct DefaultDecoder<T: Decodable> {

  func decode(data: Data) -> T? {
    do {
      let decoder = JSONDecoder()
      let decoded = try decoder.decode(T.self, from: data)
      return decoded
    } catch( let error ) {

      if let decodingError = error as? DecodingError {
        // Source [Code below] [https://stackoverflow.com/questions/52539444/printing-decodingerror-details-on-decode-failed-in-swift]
        switch decodingError {
        case .typeMismatch(let key, let value):
          print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
        case .valueNotFound(let key, let value):
          print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
        case .keyNotFound(let key, let value):
          print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
        case .dataCorrupted(let key):
          print("error \(key), and ERROR: \(error.localizedDescription)")
        default:
          print("ERROR: \(error.localizedDescription)")
        }
      }
      return nil
    }
  }


}
