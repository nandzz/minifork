//
//  AppDelegate.swift
//  Minifork
//
//  Created by Felipe Fernandes on 15/12/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var mainCoordinator: Coordinator?
  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let navigation = DefaultNavigation(item: UINavigationController())
    let coordinator = CoordinatorFactory().makeRestaurantListCoordinator(with: navigation)

    //MARK: DEBUG PURPOSE(Retain Cycle)
//    DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
//      self?.window?.rootViewController?.dismiss(animated: true, completion: nil)
//      self?.window = nil
//      self?.mainCoordinator = nil
//    }
    mainCoordinator = coordinator
    mainCoordinator?.start()

    self.window = UIWindow()
    self.window?.rootViewController = navigation.item
    self.window?.makeKeyAndVisible()

    // Used to print the path to sqlite db
    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    print(paths[0])
    return true
  }

}

