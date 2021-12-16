//
//  CoreDataStorage.swift
//  Minifork
//
//  Created by Felipe Fernandes on 16/12/21.
//

import Foundation
import CoreData

enum CoreDataError: Error {
  case readError(Error)
  case saveError(Error)
  case deleteError(Error)
  case errorConverting
}

final class LocalDataStorage {

  static let shared = CoreDataStorage()

  private init() {}

  private lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "LocalDataStorage")
      container.loadPersistentStores { _, error in
          if let error = error as NSError? {
              assertionFailure("CoreDataStorage Unresolved error \(error), \(error.userInfo)")
          }
      }
      return container
  }()

  func saveContext() {
      let context = persistentContainer.viewContext
      if context.hasChanges {
          do {
              try context.save()
          } catch {
              assertionFailure("CoreDataStorage Unresolved error \(error), \((error as NSError).userInfo)")
          }
      }
  }

  func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
      persistentContainer.performBackgroundTask(block)
  }

}


