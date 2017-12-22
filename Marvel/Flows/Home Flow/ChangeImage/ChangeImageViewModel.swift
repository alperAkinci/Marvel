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

    //MARK: Inputs

    /// Called when image is selected.
    let selectImage: AnyObserver<UIImage>

    /// Called to close ChangeImage screen.
    let cancel: AnyObserver<Void>


    //MARK: Outputs

    let didSelectImage: Observable<UIImage>

    let didCancel: Observable<Void>

    init() {

        let _selectImage = PublishSubject<UIImage>()
        self.selectImage = _selectImage.asObserver()
        self.didSelectImage = _selectImage.asObservable()


        let _cancel = PublishSubject<Void>()
        self.cancel = _cancel.asObserver()
        self.didCancel = _cancel.asObservable()
    }

}
