//
//  ApplicationCoordinatoe.swift
//  Marvel
//
//  Created by Alper Akinci on 23/11/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//



import Foundation

// TODO: Create better custom instructer
fileprivate var tutorialWasShown = true
fileprivate var isAutorized = true

fileprivate enum LaunchInstructor {
    case main, auth, tutorial

    static func configure(
        tutorialWasShown: Bool = tutorialWasShown,
        isAutorized: Bool = isAutorized) -> LaunchInstructor {

        switch (tutorialWasShown, isAutorized) {
        case (true, false):
            return .auth
        case (false, true), (false, false):
            return .tutorial
        case (true, true):
            return .main
        }
    }
}

final class ApplicationCoordinator: BaseCoordinator {

    private let coordinatorFactory: CoordinatorFactory
    private let router: Router

    private var instructor: LaunchInstructor {
        return LaunchInstructor.configure()
    }

    // MARK: - Init
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }

    override func start() {
        switch instructor {
        case .tutorial:
            //runTutorialFlow()
            break
        case .auth:
            //runAuthFlow()
            break
        case .main:
            runMainFlow()
            break
        }
    }

    private func runMainFlow() {

        let (coordinator,module) = coordinatorFactory.makeTabbarCoordinator()
        // finish main flow
        coordinator.finishFlow = { [weak self, weak coordinator] in
            print("Close Main Flow")
            isAutorized = false
            self?.start()
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        router.setRootModule(module, hideBar: true)
        coordinator.start()
    }

//    private func runAuthFlow() {
//        let coordinator = coordinatorFactory.makeAuthCoordinatorBox(router: router)
//        coordinator.finishFlow = { [weak self, weak coordinator] in
//            isAutorized = true
//            self?.start()
//            self?.removeDependency(coordinator)
//        }
//        addDependency(coordinator)
//        coordinator.start()
//    }

//    private func runTutorialFlow() {
//        let (coordinator, _ ) = coordinatorFactory.makeTutorialCoordinator(router: router)
//        coordinator.finishFlow = { [weak self, weak coordinator] in
//            tutorialWasShown = true
//            self?.start()
//            self?.removeDependency(coordinator)
//        }
//        addDependency(coordinator)
//        coordinator.start()
//    }

}
