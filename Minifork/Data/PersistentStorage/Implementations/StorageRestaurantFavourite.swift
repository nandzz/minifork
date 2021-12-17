//
//  StorageRestaurantFavourite.swift
//  Minifork
//
//  Created by Felipe Fernandes on 17/12/21.
//

import Foundation
import CoreData

class DefaultStorageRestaurantFavourite {

  private let localStorage: LocalDataStorage

  init(localStorage: LocalDataStorage = LocalDataStorage.shared) {
    self.localStorage = localStorage
  }

  func getRestaurantByUUID(uuid: String) {

  }

}

extension DefaultStorageRestaurantFavourite: RestaurantPersitenceStorage {

  func removeFavouriteRestaurant(uuid: String, completion: @escaping StoragePersistenceCompletion<Void>) {

    localStorage.performBackgroundTask { context in

      do {
        let fetchRequest: NSFetchRequest<RestaurantEntity>
        fetchRequest = RestaurantEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", uuid)
        let objects = try context.fetch(fetchRequest)

        for obj in objects {

          if let address = obj.address {
            context.delete(address)
          }
          if let ratings = obj.aggregateRatings {
            if let trip = ratings.tripadvisor {
              context.delete(trip)
            }
            if let thefork = ratings.thefork {
              context.delete(thefork)
            }
            context.delete(ratings)
          }
          if let picture = obj.mainPhoto {
            context.delete(picture)
          }
          if let bestOffer = obj.bestOffer {
            context.delete(bestOffer)
          }

          context.delete(obj)

          print("Deleting Record from DB")
        }

        try context.save()
        completion(.success(()))
      } catch (let error) {
        completion(.failure(CoreDataError.deleteError(error)))
      }
    }
  }

  func getFavouriteRestaurantList(completion: @escaping StoragePersistenceCompletion<[RestaurantDTO]>) {
    localStorage.performBackgroundTask { context in
      do  {
        let fetchRequest: NSFetchRequest<RestaurantEntity>
        fetchRequest = RestaurantEntity.fetchRequest()
        let entityRequest = try context.fetch(fetchRequest)
        let dto = try entityRequest.map({ try $0.toDTO() })
        completion(.success(dto))
      } catch(let error) {
        // Return Local Data Error
        completion(.failure(error))
      }
    }
  }

  func saveFavouriteRestaurant(restautant: RestaurantDTO, completion: @escaping StoragePersistenceCompletion<RestaurantDTO>) {
    localStorage.performBackgroundTask { context in
      do {
        _ = restautant.toEntity(in: context)
        try context.save()
        completion(.success(restautant))
      } catch (let error) {
        completion(.failure(error))
      }
    }
  }


}

