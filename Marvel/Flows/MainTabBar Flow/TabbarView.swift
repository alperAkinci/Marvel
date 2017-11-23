//
//  TabBarView.swift
//  Marvel
//
//  Created by Alper Akinci on 23/11/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import UIKit

protocol TabbarView: class {
    var onHomeFlowSelect: ((UINavigationController) -> ())? { get set }
    var onBrowseFlowSelect: ((UINavigationController) -> ())? { get set }
    var onViewDidLoad: ((UINavigationController) -> ())? { get set }
}
