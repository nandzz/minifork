//
//  testPictureService.swift
//  MiniforkTests
//
//  Created by Felipe Fernandes on 17/12/21.
//

import XCTest
@testable import Minifork

class testPictureService: XCTestCase {



  func testEndPointCreationForURL() throws {
    let url = "https://res.cloudinary.com/tf-lab/image/upload/f_auto,q_auto,w_480,h_270/restaurant/b1d8f006-2477-4715-b937-2c34d616dccb/68e364a6-e903-4fb1-9e1e-d91d97457266.jpg"

    let endPoint = try ServiceEndPoints.restaurantPicture(url: url)
    print(endPoint.path)
  }

  func testSchemeAndHostCreation() throws {
    let url = "https://res.cloudinary.com/tf-lab/image/upload/f_auto,q_auto,w_480,h_270/restaurant/b1d8f006-2477-4715-b937-2c34d616dccb/68e364a6-e903-4fb1-9e1e-d91d97457266.jpg"

    


  }



}
