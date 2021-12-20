//
//  ViewModelType.swift
//  Minifork
//
//  Created by Felipe Fernandes on 19/12/21.
//

import Foundation


protocol ViewModelType {
  associatedtype Input
  associatedtype Output

  @discardableResult
  func transform(input: Input) -> Output
}
  
