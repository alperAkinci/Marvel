//
//  Coordinator.swift
//  Marvel
//
//  Created by Alper Akinci on 23/11/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import Foundation
// All Coordinators must conform this protocol
// It means if you want to run a new flow you need to create a Coordinator using a factory and call start().
protocol Coordinator: class {
    func start()
    //func start(with option: DeepLinkOption?)
}

extension Coordinator {
    func start() {
    }
}
