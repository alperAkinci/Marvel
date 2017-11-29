//
//  BrowseCoordinator.swift
//  Marvel
//
//  Created by Alper Akinci on 23/11/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import Foundation

// Use BrowseCoordinatorOutput if browser coordinator is going to finish itself (var finishFlow: (() -> Void)?)
// Currently i dont finish browse coordinator, so i dont need BrowseCoordinatorOutput
final class BrowseCoordinator: BaseCoordinator{

    private let factory: BrowseModuleFactory
    private let router: Router

    init(router: Router, factory: BrowseModuleFactory) {
        self.factory = factory
        self.router = router
    }

    override func start() {
        showBrowse()
    }

    //MARK: - Run current flow's controllers

    private func showBrowse() {
        let browseOutput = factory.makeBrowseOutput()   
        router.setRootModule(browseOutput)
    }
}
