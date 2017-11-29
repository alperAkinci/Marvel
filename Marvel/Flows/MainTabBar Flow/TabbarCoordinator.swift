//
//  TabbarCoordinator.swift
//  Marvel
//
//  Created by Alper Akinci on 23/11/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import Foundation
import UIKit

class TabbarCoordinator: BaseCoordinator {

    private let tabbarView: TabbarView
    private let coordinatorFactory: CoordinatorFactory

    init(tabbarView: TabbarView, coordinatorFactory: CoordinatorFactory) {
        self.tabbarView = tabbarView
        self.coordinatorFactory = coordinatorFactory
    }

    override func start() {
        tabbarView.onViewDidLoad = runHomeFlow()
        tabbarView.onHomeFlowSelect = runHomeFlow()
        tabbarView.onHomeFlowSelect = runBrowseFlow()
    }

    // Run Flows
    private func runHomeFlow() -> ((UINavigationController) -> ()) {
        return { navController in
            if navController.viewControllers.isEmpty == true {
                let homeCoordinator = self.coordinatorFactory.makeHomeCoordinator(navController: navController)
                homeCoordinator.start()
                self.addDependency(homeCoordinator)
            }
        }
    }

    private func runBrowseFlow() -> ((UINavigationController) -> ()) {
        return { navController in
            if navController.viewControllers.isEmpty == true {
                let browseCoordinator = self.coordinatorFactory.makeBrowseCoordinator(navController: navController)
                browseCoordinator.start()
                self.addDependency(browseCoordinator) 
            }
        }
    }
}
