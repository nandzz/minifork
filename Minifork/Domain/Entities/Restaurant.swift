//
//  Restaurant.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation


struct RestaurantList {
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
  let mainPhoto: Picture?
  let bestOffer: BestOffer


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
    let thefork: Rating
    let tripadvisor: Rating
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
}

extension RestaurantList {
  func toDTO() -> RestaurantListDTO {
    return .init(data: list.map({ $0.toDTO() }))
  }
}

extension Restaurant {
  func toDTO() -> RestaurantDTO {
    return .init(name: self.name,
                 uuid: self.uuid,
                 servesCuisine: self.servesCuisine,
                 priceRange: self.priceRange,
                 currenciesAccepted: self.currenciesAccepted,
                 address: self.address.toDTO(),
                 aggregateRatings: self.aggregateRatings.toDTO(),
                 mainPhoto: self.mainPhoto?.toDTO(),
                 bestOffer: self.bestOffer.toDTO())
  }
}

extension Restaurant.Address {

  func toDTO() -> RestaurantDTO.AddressDTO {
    return .init(
      street: self.street,
      postalCode: self.postalCode,
      locality: self.locality,
      country: self.country)
  }
}

extension Restaurant.BestOffer {
  func toDTO() -> RestaurantDTO.BestOfferDTO {
    return .init(name: self.name,
                 label: self.label)
  }
}

extension Restaurant.Picture {
  func toDTO() -> RestaurantDTO.PictureDTO {
    return .init(small: self.small,
                 medium: self.medium,
                 big: self.big)
  }
}

extension Restaurant.Rating {
  func toDTO() -> RestaurantDTO.RatingDTO {
    return .init(ratingValue: self.ratingValue,
                 reviewCount: self.reviewCount)
  }
}

extension Restaurant.Ratings {
  func toDTO() -> RestaurantDTO.RatingsDTO {
    return .init(thefork: self.thefork.toDTO(), tripadvisor: self.tripadvisor.toDTO())
  }
}

extension Restaurant {
  static func mock(uuid: String) -> Restaurant {
    return Restaurant(name: "SushiKing", uuid: uuid, servesCuisine: "Cinese", priceRange: 23, currenciesAccepted: "EUA", address: Address(street: "Lucio Dalla", postalCode: "2003", locality: "VI", country: "Italia"), aggregateRatings: Ratings(thefork: Rating(ratingValue: 20.0, reviewCount: 4), tripadvisor: Rating(ratingValue: 20.3, reviewCount: 39)), mainPhoto: nil, bestOffer: BestOffer(name: "SushiOut", label: "50% Discount"))
  }
}
