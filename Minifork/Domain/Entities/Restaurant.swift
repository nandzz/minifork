//
//  Restaurant.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation

struct RestaurantList {
  var list: [Restaurant]
}

class Restaurant {

  let name: String
  let uuid: String
  let servesCuisine: String
  let priceRange: Double
  let currenciesAccepted: String
  let address: Address
  let aggregateRatings: Ratings
  let mainPhoto: Picture?
  let bestOffer: BestOffer
  var isFavourite: Bool = false
  var key: DefaultCacheKey

  init(name: String,
       uuid: String,
       servesCuisine: String,
       priceRange: Double,
       currenciesAccepted: String,
       address: Address,
       aggregateRatings: Ratings,
       mainPhoto: Picture?,
       bestOffer: BestOffer,
       key: DefaultCacheKey) {
    self.name = name
    self.uuid = uuid
    self.servesCuisine = servesCuisine
    self.priceRange = priceRange
    self.currenciesAccepted = currenciesAccepted
    self.address = address
    self.aggregateRatings = aggregateRatings
    self.mainPhoto = mainPhoto
    self.bestOffer = bestOffer
    self.isFavourite = false
    self.key = key
  }

  func getName() -> String {
    return self.name
  }

  func getCousine()  -> String {
    return self.servesCuisine
  }

  func getPriceRange() -> String {
    return "0 - \(Int(priceRange))"
  }

  func getAddressStreet () -> String  {
    return self.address.street
  }

  func getCityCountry () -> String {
    return "\(address.locality), \(address.country)"
  }

  func getBestOffer () -> String {
    return "\(bestOffer.name)"
  }

  func getTripAdRate() -> String {
    return "\(aggregateRatings.tripadvisor.ratingValue)/5"
  }

  func getTheForkRate () -> String {
    return "\(aggregateRatings.thefork.ratingValue)/10"
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
    var obj =  RestaurantDTO(name: self.name,
                 uuid: self.uuid,
                 servesCuisine: self.servesCuisine,
                 priceRange: self.priceRange,
                 currenciesAccepted: self.currenciesAccepted,
                 address: self.address.toDTO(),
                 aggregateRatings: self.aggregateRatings.toDTO(),
                 mainPhoto: self.mainPhoto?.toDTO(),
                 bestOffer: self.bestOffer.toDTO())
    obj.key = self.key
    return obj
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
    return Restaurant(name: "SushiKing", uuid: uuid, servesCuisine: "Cinese", priceRange: 23, currenciesAccepted: "EUA", address: Address(street: "Lucio Dalla", postalCode: "2003", locality: "VI", country: "Italia"), aggregateRatings: Ratings(thefork: Rating(ratingValue: 20.0, reviewCount: 4), tripadvisor: Rating(ratingValue: 20.3, reviewCount: 39)), mainPhoto: Picture(small: "", medium: "https://res.cloudinary.com/tf-lab/image/upload/f_auto,q_auto,w_480,h_270/restaurant/3da6a3db-1080-4e1e-8438-1e82ca838100/ff083b11-2a3a-4b4c-8e92-21ef2afe712a.jpg", big: ""), bestOffer: BestOffer(name: "SushiOut", label: "50% Discount"), key: DefaultCacheKey(uuid: UUID()))
  }
}
