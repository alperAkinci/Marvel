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
    // if user selects comic, trigger this method
    var onHideButtonTap: (() -> Void)? { get set }
    var onCompleteSelectImage: (() -> Void)? { get set }
    var selectedImageSubject: PublishSubject<UIImage> { get set }
    //var onFinish: (() -> Void)? { get set }
}

