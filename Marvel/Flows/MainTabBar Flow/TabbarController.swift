//
//  TabbarController.swift
//  Marvel
//
//  Created by Alper Akinci on 23/11/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import Foundation
import UIKit

final class TabbarController: UITabBarController, UITabBarControllerDelegate, TabbarView{

    var onHomeFlowSelect: ((UINavigationController) -> ())?
    var onBrowseFlowSelect: ((UINavigationController) -> ())?
    var onViewDidLoad: ((UINavigationController) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        if let controller = customizableViewControllers?.first as? UINavigationController {
            onViewDidLoad?(controller)
        }
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let controller = viewControllers?[selectedIndex] as? UINavigationController else { return }

        if selectedIndex == 0 {
            onHomeFlowSelect?(controller)
        }
        else if selectedIndex == 1 {
            onBrowseFlowSelect?(controller)
        }
    }
}
