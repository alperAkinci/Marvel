//
//  ImageSection.swift
//  Marvel
//
//  Created by Alper Akinci on 28/12/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import Foundation
import RxDataSources

struct ImageSection {
    var images: [ImageItem]
}

struct ImageItem {
    var image: UIImage

    init(image: UIImage){
        self.image = image
    }
}

extension ImageSection: SectionModelType {
    typealias Item = ImageItem

    var items: [ImageItem] {
        return images
    }

    init(original: ImageSection, items: [ImageItem]) {
        self = original
        self.images = items
    }
}
