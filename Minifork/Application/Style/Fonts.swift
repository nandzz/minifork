//
//  Fonts.swift
//  Minifork
//
//  Created by Felipe Fernandes on 18/12/21.
//

import Foundation
import UIKit


struct Font {

  enum Traits: String {

    case SemiBold
    case Medium
    case Bold
    case Regular
    case ExtraBold
    case Black
    
  }

  static func get(trait: Traits, size: CGFloat) -> UIFont {
    switch trait {
    case .Black:
      return UIFont.systemFont(ofSize: size, weight: .black)
    case .Bold:
      return UIFont.systemFont(ofSize: size, weight: .bold)
    case .ExtraBold:
      return UIFont.systemFont(ofSize: size, weight: .heavy)
    case .Medium:
      return UIFont.systemFont(ofSize: size, weight: .medium)
    case .Regular:
      return UIFont.systemFont(ofSize: size, weight: .regular)
    case .SemiBold:
      return UIFont.systemFont(ofSize: size, weight: .semibold)
    }

  }

}
