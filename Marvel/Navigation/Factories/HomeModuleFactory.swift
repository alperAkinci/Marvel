//
//  HomeModuleFactory.swift
//  Marvel
//
//  Created by Alper Akinci on 23/11/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import Foundation

// Currently home module shows comics
protocol HomeModuleFactory {
    func makeHomeOutput() -> HomeView
    func makeChangeImageOutput() -> ChangeImageView
    //func makeComicDetailOutput(comic: ComicList) -> ComicDetailView
}

