//
//  RestaurantRepositoryInterface.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation


protocol RepositoryRestaurantList {

  var service: RestaurantService { get }
  func getRestaurantList(completion: @escaping RepositoryCompletionResponse<RestaurantListDTO>)
}
