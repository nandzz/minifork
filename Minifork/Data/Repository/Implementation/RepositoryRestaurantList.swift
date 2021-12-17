//
//  RestaurantRepository.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation


class DefaultRepositoryRestaurantList: RepositoryRestaurantList {

  var service: RestaurantService

  init(service: RestaurantService) {
    self.service = service
  }

  func getRestaurantList(completion: @escaping RepositoryCompletionResponse<RestaurantListDTO>) {
    let endPoint = ServiceEndPoints.restaurantList()
    let request = ServiceRequests.restaurantList(endPoint: endPoint)
    service.getRestaurantList(request: request) { result in
      switch result {
      case .success(let data):
        guard let serviceData = data else {
          completion(.failure(NetworkTypeError.ErrorWaitingDataButNotPresent))
          return
        }
        guard let dataModel = DefaultDecoder<RestaurantListDTO>().decode(data: serviceData) else {
          completion(.failure(NetworkTypeError.ErrorDecoding))
          return
        }
        completion(.success(dataModel))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func saveFavouriteRestaurant(restaurant: RestaurantDTO) {
    fatalError()
  }

  func getFavouriteRestaurantList() {
    fatalError()
  }



}
