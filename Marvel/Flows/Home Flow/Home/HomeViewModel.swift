//
//  HomeViewModel.swift
//  Marvel
//
//  Created by Alper Akinci on 22/12/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel {

    //MARK: Inputs

    /// Call to update image.
    let setCurrentImage: AnyObserver<UIImage>

    /// Call to ChangeImage screen.
    let onChangeImageSelect: AnyObserver<UIImage?>


    //MARK: Outputs

    /// Emits a current selected image.
    let image: Observable<UIImage>

    init(initialImage: UIImage = #imageLiteral(resourceName: "rxswift")) {
        let _onChangeImageSelect = PublishSubject<UIImage?>()
        self.onChangeImageSelect = _onChangeImageSelect.asObserver()

        var _currentImage = BehaviorSubject<UIImage>(value: initialImage)
        self.setCurrentImage = _currentImage.asObserver()

        self.image = _currentImage.asObservable()
    }
}
