//
//  HomeView.swift
//  Marvel
//
//  Created by Alper Akinci on 23/11/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import Foundation

protocol HomeView: BaseView {
    var onComicSelect: ((ComicList) -> ())? { get set }
    //var onFinish: (() -> Void)? { get set }
}

