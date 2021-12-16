//
//  Restaurant.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation


struct RestaurntList {
  let list: [Restaurant]
}

struct Restaurant {

  let name: String
  let uuid: String
  let servesCuisine: String
  let priceRange: Double
  let currenciesAccepted: String
  let address: Address
  let aggregateRatings: Ratings
  let mainPhoto: Picture
  let bestOffer: BestOffer
}

struct Address {
  let street: String
  let postalCode: String
  let locality: String
  let country: String
}

struct Rating {
  let ratingValue: Double
  let reviewCount: Int
}

struct Ratings {
  let theFork: Rating
  let tripAdvisor: Rating
}

struct Picture {
  let small: String
  let medium: String
  let big: String
}

struct BestOffer {
  let name: String
  let label: String
}
