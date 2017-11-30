//
//  AppDelegate.swift
//  Marvel
//
//  Created by Alper Akinci on 22/11/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootController: UINavigationController {
        return self.window?.rootViewController as! UINavigationController
    }

    lazy var applicationCoordinator: Coordinator = ApplicationCoordinator(
        router: RouterImp(rootController: self.rootController),
        coordinatorFactory: CoordinatorFactoryImp())

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        applicationCoordinator.start() // runs MainFlow
        return true
    }
}

