//
//  HomeView.swift
//  Marvel
//
//  Created by Alper Akinci on 23/11/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol HomeView: BaseView {
    var viewModel: HomeViewModel! { get set }
}
