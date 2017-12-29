//
//  ChangeImageView.swift
//  Marvel
//
//  Created by Alper Akinci on 01/12/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol ChangeImageView: BaseView {
    var viewModel: ChangeImageViewModel! { get set }
}

