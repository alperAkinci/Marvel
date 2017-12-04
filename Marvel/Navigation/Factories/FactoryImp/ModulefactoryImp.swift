//
//  ModulefactoryImp.swift
//  Marvel
//
//  Created by Alper Akinci on 23/11/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import Foundation

// Used in Coordinators to initialize modules (coordinators)
class ModuleFactoryImp: HomeModuleFactory, BrowseModuleFactory {

    func makeHomeOutput() -> HomeView {
        return HomeController.controllerFromStoryboard(.home)
    }

    func makeChangeImageOutput() -> ChangeImageView {
        return ChangeImageController.controllerFromStoryboard(.home)
    }

    func makeBrowseOutput() -> BrowseView {
        return BrowseController.controllerFromStoryboard(.browse)
    }
}
