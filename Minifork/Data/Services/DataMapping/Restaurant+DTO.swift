//
//  Restaurant+DTO.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation


struct RestaurantList: Decodable {
  let list: [RestaurantDTO]
}

struct RestaurantDTO: Decodable {

  let name: String
  let uuid: String
  let servesCuisine: String
  let priceRange: Double
  let currenciesAccepted: String
  let address: AddressDTO
  let aggregateRatings: RatingsDTO
  let mainPhoto: PictureDTO
  let bestOffer: BestOfferDTO
}

struct AddressDTO: Decodable {
  let street: String
  let postalCode: String
  let locality: String
  let country: String
}

struct RatingDTO: Decodable {
  let ratingValue: Double
  let reviewCount: Int
}

struct RatingsDTO: Decodable {
  let theFork: RatingDTO
  let tripAdvisor: RatingDTO
}

struct PictureDTO: Decodable {
  let small: String
  let medium: String
  let big: String
}

struct BestOfferDTO: Decodable {
  let name: String
  let label: String
}
