//
//  BaseCoordinator.swift
//  Marvel
//
//  Created by Alper Akinci on 23/11/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import Foundation

/**
 # All Coordinators must inherit from a base coordinator.
 The base Coordinator class keeps all dependency logic.
 We need it for memory management reasons, to keep strong references to all child coordinators, and to allow Coordinators to call functions on their children (this is how deep linking works).
 */
class BaseCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []

    func start() {
    }

    // add only unique object
    func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: Coordinator?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
            else { return }

        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
