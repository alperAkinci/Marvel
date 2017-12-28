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

    @IBOutlet var images: [UIButton]!

    let disposeBag = DisposeBag()
    var viewModel: ChangeImageViewModel!

    var onCompleteSelectImage: (() -> Void)?
    var completeSelectImage = PublishSubject<UIImage>()

    private var cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
    private var doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.leftBarButtonItem = cancelButton

        setupBindings()
    }

    func setupBindings() {

        // View Controller UI actions to the View Model inputs

        // TODO: Add comment, refactor
        for imageBtn in images {
            imageBtn.rx.tap
                .debug("Button Pressed")
                .subscribe(onNext: { [weak self] _ in
                self?.resetButtonBackgroundColors()
                imageBtn.backgroundColor = UIColor.black
            }).disposed(by: disposeBag)

           imageBtn.rx.tap
                .map({ imageBtn.imageView?.image})
                .bind(to: viewModel.selectedImage)
                .disposed(by: disposeBag)
        }

        // TODO: without using image variable, binding gives error, fix it
        let image = doneButton.rx.tap
            .map { self.viewModel.selectedImage.value }
            .map { $0!}
        image.bind(to: viewModel.done).disposed(by: disposeBag)

        cancelButton.rx.tap
            .bind(to: viewModel.cancel)
            .disposed(by: disposeBag)
    }

    func resetButtonBackgroundColors() {
        for btn in images {
            btn.backgroundColor = UIColor.white
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // TODO: There is a memory leak, all resources are not disposed after Change Image module closed
        print("resources: \(RxSwift.Resources.total)")
    }
}
