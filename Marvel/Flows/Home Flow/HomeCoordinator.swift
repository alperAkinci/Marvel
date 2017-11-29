//
//  HomeCoordinator.swift
//  Marvel
//
//  Created by Alper Akinci on 23/11/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import Foundation

final class HomeCoordinator: BaseCoordinator {

    private let factory: HomeModuleFactory

    //if you are going to change different coordinator this property needed
    private let coordinatorFactory: CoordinatorFactory

    private let router: Router

    init(router: Router, factory: HomeModuleFactory, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
    }

    override func start() {
        showComicList()
    }

    //MARK: - Run controllers belong to homeCoordinator (Home Flow)

    private func showComicList() {

        let comicsOutput = factory.makeComicsOutput()

        // if comic selected, show detail screen
        comicsOutput.onComicSelect = { [weak self] (item) in
            //self?.showComicDetail(item)
        }

//       Creating new comic
//        comicsOutput.onCreateItem = { [weak self] in
//            self?.runCreationFlow()
//        }

        router.setRootModule(comicsOutput)
    }
/// - Comic Detail Screen
//    private func showComicDetail(_ comic: ComicList) {
//
//        let itemDetailFlowOutput = factory.makeItemDetailOutput(item: item)
//        router.push(itemDetailFlowOutput)
//    }


// MARK: - Run coordinators (switch to another flow)


// - Creating Flow for comic detail
//    private func runCreationFlow() {
//
//        let (coordinator, module) = coordinatorFactory.makeItemCreationCoordinatorBox()
//        coordinator.finishFlow = { [weak self, weak coordinator] item in
//
//            self?.router.dismissModule()
//            self?.removeDependency(coordinator)
//            if let item = item {
//                self?.showItemDetail(item)
//            }
//        }
//        addDependency(coordinator)
//        router.present(module)
//        coordinator.start()
//    }
}
