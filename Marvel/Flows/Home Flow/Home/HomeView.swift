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
    // if user selects comic, trigger this method
    var onComicSelect: ((ComicList) -> ())? { get set }
    //var onChangeImageSelect: ((UIImage?) -> ())? { get set }
    var imageVariable: Variable<UIImage?> { get set }
    //var onFinish: (() -> Void)? { get set }
    var onChangeImageSelect: PublishSubject<UIImage?> { get set }
}

struct ComicList {

}

