//
//  RestaurantEntity+Mapping.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation
import CoreData


extension RestaurantEntity {
  func toDTO() throws ->  RestaurantDTO {

    guard let address = self.address else {
      throw CoreDataError.errorConverting
    }

    guard let bestOffer = self.bestOffer else {
      throw CoreDataError.errorConverting
    }

    guard let aggregateRatings = self.aggregateRatings else {
      throw CoreDataError.errorConverting
    }

    return .init(name: self.name ?? "",
                 uuid: self.uuid ?? "",
                 servesCuisine: self.servesCuisine ?? "",
                 priceRange: self.priceRange,
                 currenciesAccepted: self.currenciesAccepted ?? "",
                 address: address.toDTO(),
                 aggregateRatings: try aggregateRatings.toDTO(),
                 mainPhoto: self.mainPhoto?.toDTO(),
                 bestOffer: bestOffer.toDTO())
  }
}

extension AddressEntity {

  func toDTO() -> RestaurantDTO.AddressDTO {
    return .init(
      street: self.street ?? "",
      postalCode: self.postalCode ?? "",
      locality: self.locality ?? "",
      country: self.country ?? "")
  }
}

extension BestOfferEntity {
  func toDTO() -> RestaurantDTO.BestOfferDTO {
    return .init(name: self.name ?? "",
                 label: self.label ?? "")
  }
}

extension PictureEntity {
  func toDTO() -> RestaurantDTO.PictureDTO {
    return .init(small: self.small ?? "",
                 medium: self.medium ?? "",
                 big: self.big ?? "")
  }
}

extension RatingEntity {
  func toDTO() -> RestaurantDTO.RatingDTO {
    return .init(ratingValue: self.ratingValue,
                 reviewCount: Int(self.reviewCount))
  }
}

extension RatingsEntity {
  func toDTO() throws -> RestaurantDTO.RatingsDTO {
    guard let theFork = self.thefork else {
      throw CoreDataError.errorConverting
    }

    guard let tripAdvisor = self.tripadvisor else {
      throw CoreDataError.errorConverting
    }
    return .init(thefork: theFork.toDTO(), tripadvisor: tripAdvisor.toDTO())
  }
}




extension RestaurantDTO {
  func toEntity(in context: NSManagedObjectContext ) -> RestaurantEntity {
    let entity: RestaurantEntity = .init(context: context)
    entity.name = self.name
    entity.uuid = self.uuid
    entity.servesCuisine = self.servesCuisine
    entity.priceRange = self.priceRange
    entity.currenciesAccepted = self.currenciesAccepted
    entity.address = self.address.toEntity(in: context)
    entity.aggregateRatings = self.aggregateRatings.toEntity(in: context)
    entity.mainPhoto = self.mainPhoto?.toEntity(in: context)
    entity.bestOffer = self.bestOffer.toEntity(in: context)
    return entity
  }
}

extension RestaurantDTO.AddressDTO {

  func toEntity(in context: NSManagedObjectContext) -> AddressEntity {
    let entity: AddressEntity = .init(context: context)
    entity.street =  self.street
    entity.postalCode = self.postalCode
    entity.locality = self.locality
    entity.country = self.country
    return entity
  }
}

extension RestaurantDTO.BestOfferDTO {
  func toEntity(in context: NSManagedObjectContext) -> BestOfferEntity {
    let entity: BestOfferEntity = .init(context: context)
    entity.name = self.name
    entity.label = self.label
    return entity
  }
}

extension RestaurantDTO.PictureDTO {
  func toEntity(in context: NSManagedObjectContext) -> PictureEntity {
    let entity: PictureEntity = .init(context: context)
    entity.small = self.small
    entity.medium = self.medium
    entity.big = self.big
    return entity
  }
}

extension RestaurantDTO.RatingDTO {
  func toEntity(in context: NSManagedObjectContext) -> RatingEntity {
    let entity: RatingEntity = .init(context: context)

    entity.ratingValue = self.ratingValue
    entity.reviewCount = Int32(self.reviewCount)
    return entity
  }
}

extension RestaurantDTO.RatingsDTO {
  func toEntity(in context: NSManagedObjectContext) -> RatingsEntity {
    let entity: RatingsEntity = .init(context: context)
    entity.thefork = self.thefork.toEntity(in: context)
    entity.tripadvisor = self.tripadvisor.toEntity(in: context)
    return entity
  }
}





