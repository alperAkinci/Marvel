//
//  ChangeImageViewModel.swift
//  Marvel
//
//  Created by Alper Akinci on 12/12/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import Foundation
import RxSwift

struct ChangeImageViewModel {

    init(image: UIImage?) {
        selectedImageVariable.value = image
        selectedImage = selectedImageVariable.asObservable()
    }

    // INPUT

    //TODO: make it private 
    var selectedImageVariable = Variable<UIImage?>(UIImage())
    public func imageChanged(_ image: UIImage?) {
        self.selectedImageVariable.value = image
    }

    // OUTPUT
    var selectedImage: Observable<UIImage?>
}
