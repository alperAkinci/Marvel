//
//  ChangeImageController.swift
//  Marvel
//
//  Created by Alper Akinci on 01/12/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa  

class ChangeImageController: UIViewController, ChangeImageView {
    
    var onHideButtonTap: (() -> Void)?
    var onCompleteSelectImage: (() -> Void)?

    // TODO: Make it fileprivate
    var selectedImageSubject = PublishSubject<UIImage>()

    //Subscribing to this property is how the main controller can observe the image sequence
    var selectedImage: Observable<UIImage> {
        return selectedImageSubject.asObservable()
    }

    @IBOutlet var images: [UIButton]!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedImageSubject.onCompleted()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("resources: \(RxSwift.Resources.total)")
    }

    @IBAction func pressedOnImage(_ sender: UIButton) {
        guard let image = sender.imageView?.image else {
            print("No image found")
            return
        }
        selectedImageSubject.onNext(image)
        onCompleteSelectImage?()
    }
}
