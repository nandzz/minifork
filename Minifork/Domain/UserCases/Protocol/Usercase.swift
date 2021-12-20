//
//  Usercase.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation
import RxSwift



protocol UserCase {
  func start() -> Observable<Any>
}
