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

    let dummyImages = [ImageSection(images: [ImageItem(image: #imageLiteral(resourceName: "swift")),
                                             ImageItem(image: #imageLiteral(resourceName: "rxswift")),
                                             ImageItem(image: #imageLiteral(resourceName: "reactiveCocao")),
                                             ImageItem(image: #imageLiteral(resourceName: "rxswift2"))])
    ]

    /// Variable that keeps selected image
    // TODO: try with Publish Subject
    let selectedItem: Variable<ImageItem?>

    //MARK: Inputs (generally used in controllers)

    /// Called to close ChangeImage screen.
    let cancel: AnyObserver<Void>

    /// Called to close ChangeImage screen with selected image.
    let done: AnyObserver<UIImage>

    //MARK: Outputs (generally used in coordinators)

    /// Emits when we want to cancel image selection (In our case it will close the change image modeule)
    let didCancel: Observable<Void>

    /// Emits when we want to complete image selection (In our case it will close the change image modeule)
    let didDone: Observable<UIImage>

    init(with imageItem: ImageItem) {
        self.selectedItem = Variable<ImageItem?>(imageItem)

        let _cancel = PublishSubject<Void>()
        self.cancel = _cancel.asObserver()
        self.didCancel = _cancel.asObservable()

        let _done = PublishSubject<UIImage>()
        self.done = _done.asObserver()
        self.didDone = _done.asObservable()
    }

}
