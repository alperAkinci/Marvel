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

    var onCompleteSelectImage: (() -> Void)?
    var completeSelectImage = PublishSubject<UIImage>()
    var changeImageViewModel: ChangeImageViewModel!
    let disposeBag = DisposeBag()

    var doneButton: UIBarButtonItem? {
        set {
            self.navigationItem.rightBarButtonItem = newValue
        }
        get {
            return self.navigationItem.rightBarButtonItem
        }
    }

    convenience init(viewModel: ChangeImageViewModel) {
        self.init()
        self.changeImageViewModel = viewModel
    }

    @IBOutlet var images: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()

        doneButton = UIBarButtonItem(title: "Done",
                                      style: .done,
                                      target: self,
                                      action: #selector(doneButtonPressed(_:)))
        setupRx()
    }

    func setupRx() {
        // do bindings
        for imageBtn in images {
            imageBtn.rx
                .tap
                .debug("Button Pressed")
                .subscribe(onNext: { [weak self] in
                guard let image = imageBtn.imageView?.image else {
                    print("No image found")
                    return
                }
                self?.resetButtonBackgroundColors()
                imageBtn.backgroundColor = UIColor.black
                self?.changeImageViewModel.imageChanged(image)
            }).disposed(by: disposeBag)
        }
    }

    func resetButtonBackgroundColors() {
        for btn in images {
            btn.backgroundColor = UIColor.white
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("resources: \(RxSwift.Resources.total)")
    }

    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        var selectedImage = self.changeImageViewModel.selectedImageVariable.value
        self.completeSelectImage.onNext(selectedImage!)
    }
}
