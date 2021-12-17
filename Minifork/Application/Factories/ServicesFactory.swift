//
//  ServicesFactory.swift
//  Minifork
//
//  Created by Felipe Fernandes on 17/12/21.
//

import Foundation



struct ServicesFactory {

  //MARK: Restaurant List
  func createRestaurantListService () -> RestaurantService {
    let configuration = DefaultNetworkConfiguration(baseURL: .url(scheme: "https", host: "alanflament.github.io"))
    return DefaultService(configuration: configuration)
  }

  //MARK: Restaurant Picture
  func createRestaurantPictureService(url: String) throws -> PictureService {
    guard let url = URL(string: url), let scheme = url.scheme, let host = url.host else {
      throw NetworkTypeError.errorWithMessage("Wrong URL Format for Image Request")
    }
    let configuration = DefaultNetworkConfiguration(baseURL:.url(scheme: scheme,
                                                                 host: host))
    return DefaultService(configuration: configuration)
  }


}
