//
//  Navigation.swift
//  Minifork
//
//  Created by Felipe Fernandes on 19/12/21.
//

import Foundation
import UIKit

extension UIViewController {

  func setLogo() {
    let logo = UIImage(named: "logo-ts")
    let imageView = UIImageView(image:logo)
    self.navigationItem.titleView = imageView
  }

}
