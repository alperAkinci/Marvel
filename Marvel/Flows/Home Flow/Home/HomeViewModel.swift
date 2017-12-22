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
    let setImage: AnyObserver<UIImage>

    /// Call to ChangeImage screen.
    let changeImage: AnyObserver<Void>


    //MARK: Outputs

    /// Emits a current selected image.
    let image: Observable<UIImage>

    /// Emits when we should show show ChangeImage screen.
    let showChangeImage: Observable<Void>

    init(initialImage: UIImage = #imageLiteral(resourceName: "rxswift")) {

        let _currentImage = BehaviorSubject<UIImage>(value: initialImage)
        self.setImage = _currentImage.asObserver()
        self.image = _currentImage.asObservable()


        let _changeImage = PublishSubject<Void>()
        self.changeImage = _changeImage.asObserver()
        self.showChangeImage = _changeImage.asObservable()
    }
}
