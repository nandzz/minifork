//
//  Color.swift
//  Minifork
//
//  Created by Felipe Fernandes on 18/12/21.
//

import Foundation
import UIKit

struct AppColor {

    static var gray = UIColor("DDDDDD")
    static var blackgray = UIColor("191919")
    static var promo = UIColor("FB8888")
    static var black = UIColor("000000")
    static var white = UIColor("FFFFFF")
}

// [Source]https://stackoverflow.com/questions/24263007/how-to-use-hex-color-values

extension UIColor {

  convenience init(_ hex: String, alpha: CGFloat = 1.0) {
    var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if cString.hasPrefix("#") { cString.removeFirst() }

    if cString.count != 6 {
      self.init("ff0000") // return red color for wrong hex input
      return
    }

    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: alpha)
  }

}
