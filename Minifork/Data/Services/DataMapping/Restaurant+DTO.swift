//
//  Restaurant+DTO.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation


struct RestaurantListDTO: Decodable {
  let data: [RestaurantDTO]
}

struct RestaurantDTO: Decodable {

  let name: String
  let uuid: String
  let servesCuisine: String
  let priceRange: Double
  let currenciesAccepted: String
  let address: AddressDTO
  let aggregateRatings: RatingsDTO
  let mainPhoto: PictureDTO?
  let bestOffer: BestOfferDTO
  var key: DefaultCacheKey = DefaultCacheKey(uuid: UUID())

  /// Needed to used CodingKeys because the decoder is trying to decode `Key`
  private enum CodingKeys: String, CodingKey {
        case name, uuid, servesCuisine, priceRange, currenciesAccepted, address, aggregateRatings, mainPhoto, bestOffer
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
    let thefork: RatingDTO
    let tripadvisor: RatingDTO
  }

  struct PictureDTO: Decodable {

    let small: String
    let medium: String
    let big: String

    private enum CodingKeys: String, CodingKey {
      case small = "240x135"
      case medium = "480x270"
      case big =  "664x374"
    }

  }

  struct BestOfferDTO: Decodable {
    let name: String
    let label: String
  }

}

extension RestaurantListDTO {
  func toDomain() -> RestaurantList {
    return .init(list: data.map({ $0.toDomain() }))
  }
}

extension RestaurantDTO {
  func toDomain() -> Restaurant {
    return .init(name: self.name,
                 uuid: self.uuid,
                 servesCuisine: self.servesCuisine,
                 priceRange: self.priceRange,
                 currenciesAccepted: self.currenciesAccepted,
                 address: self.address.toDomain(),
                 aggregateRatings: self.aggregateRatings.toDomain(),
                 mainPhoto: self.mainPhoto?.toDomain(),
                 bestOffer: self.bestOffer.toDomain(),
                 key: self.key)
  }
}

extension RestaurantDTO.AddressDTO {

  func toDomain() -> Restaurant.Address {
    return .init(
      street: self.street,
      postalCode: self.postalCode,
      locality: self.locality,
      country: self.country)
  }
}

extension RestaurantDTO.BestOfferDTO {
  func toDomain() -> Restaurant.BestOffer {
    return .init(name: self.name,
                 label: self.label)
  }
}

extension RestaurantDTO.PictureDTO {
  func toDomain() -> Restaurant.Picture {
    return .init(small: self.small,
                 medium: self.medium,
                 big: self.big)
  }
}

extension RestaurantDTO.RatingDTO {
  func toDomain() -> Restaurant.Rating {
    return .init(ratingValue: self.ratingValue,
                 reviewCount: self.reviewCount)
  }
}

extension RestaurantDTO.RatingsDTO {
  func toDomain() -> Restaurant.Ratings {
    return .init(thefork: self.thefork.toDomain(), tripadvisor: self.tripadvisor.toDomain())
  }
}


extension RestaurantDTO {
  static func mock(uuid: String) -> RestaurantDTO {
    return RestaurantDTO(name: "SushiKing", uuid: uuid, servesCuisine: "Cinese", priceRange: 23, currenciesAccepted: "EUA", address: AddressDTO(street: "Lucio Dalla", postalCode: "2003", locality: "VI", country: "Italia"), aggregateRatings: RatingsDTO(thefork: RatingDTO(ratingValue: 20.0, reviewCount: 4), tripadvisor: RatingDTO(ratingValue: 20.3, reviewCount: 39)), mainPhoto: nil, bestOffer: BestOfferDTO(name: "SushiOut", label: "50% Discount"))
  }

  static func mockWithPictureURL(uuid: String, url: String) -> RestaurantDTO {
    return RestaurantDTO(name: "SushiKing", uuid: uuid, servesCuisine: "Cinese", priceRange: 23, currenciesAccepted: "EUA", address: AddressDTO(street: "Lucio Dalla", postalCode: "2003", locality: "VI", country: "Italia"), aggregateRatings: RatingsDTO(thefork: RatingDTO(ratingValue: 20.0, reviewCount: 4), tripadvisor: RatingDTO(ratingValue: 20.3, reviewCount: 39)), mainPhoto: PictureDTO(small: url, medium: url, big: url), bestOffer: BestOfferDTO(name: "SushiOut", label: "50% Discount"))
  }
}
