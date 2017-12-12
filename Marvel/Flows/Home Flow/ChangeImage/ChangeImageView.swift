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
    var completeSelectImage: PublishSubject<UIImage> { get set }
    var onCompleteSelectImage: (() -> Void)? { get set }
    var changeImageViewModel: ChangeImageViewModel! { get set }
    //var onFinish: (() -> Void)? { get set }
}

