//
//  CoordinatorFactoryImp.swift
//  Marvel
//
//  Created by Alper Akinci on 23/11/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import Foundation
import UIKit

final class CoordinatorFactoryImp: CoordinatorFactory {

    func makeTabbarCoordinator() -> (configurator: Coordinator, toPresent: Presentable?) {
        let controller = TabbarController.controllerFromStoryboard(.main)
        let coordinator = TabbarCoordinator(tabbarView: controller, coordinatorFactory: CoordinatorFactoryImp())
        return (coordinator, controller)
    }

    // HOME
    // used when switching between tabs
    func makeHomeCoordinator(navController: UINavigationController?) -> Coordinator {
        let coordinator = HomeCoordinator(router: router(navController),
                                          factory: ModuleFactoryImp(),
                                          coordinatorFactory: CoordinatorFactoryImp())
        return coordinator
    }
    
    func makeHomeCoordinator() -> Coordinator {
        return makeHomeCoordinator(navController: nil)
    }

    // BROWSE
    func makeBrowseCoordinator(navController: UINavigationController?) -> Coordinator {
        let coordinator = BrowseCoordinator(router: router(navController),
                                            factory: ModuleFactoryImp())
        return coordinator
    }

    func makeBrowseCoordinator() -> Coordinator {
        return makeBrowseCoordinator(navController: nil)
    }

    private func router(_ navController: UINavigationController?) -> Router {
        return RouterImp(rootController: navigationController(navController))
    }

    private func navigationController(_ navController: UINavigationController?) -> UINavigationController {
        if let navController = navController { return navController }
        else { return UINavigationController.controllerFromStoryboard(.main) }
    }
}
