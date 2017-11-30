//
//  CoordinatorFactory.swift
//  Marvel
//
//  Created by Alper Akinci on 23/11/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import Foundation
import UIKit

protocol CoordinatorFactory {

    // Make tutorial Coordinator (Will be used in future)
    // func makeTutorialCoordinator(router: Router) -> (configurator: Coordinator & TutorialCoordinatorOutput, toPresent: Presentable?)

    // func makeTutorialCoordinatorBox() -> (configurator: Coordinator & TutorialCoordinatorOutput, toPresent: Presentable?)

    // func makeTutorialCoordinatorBox(navController: UINavigationController?) -> (configurator: Coordinator & TutorialCoordinatorOutput, toPresent: Presentable?)

    // Make tabbar Coordinator
    func makeTabbarCoordinator() -> (configurator: Coordinator, toPresent: Presentable?)

    // Make profile Coordinator
    func makeHomeCoordinator(navController: UINavigationController?) -> Coordinator
    func makeHomeCoordinator() -> Coordinator

    // Make browse Coordinator
    func makeBrowseCoordinator(navController: UINavigationController?) -> Coordinator
    func makeBrowseCoordinator() -> Coordinator

}
