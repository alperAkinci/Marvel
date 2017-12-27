//
//  HomeViewController.swift
//  Marvel
//
//  Created by Alper Akinci on 29/11/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class HomeController: UIViewController, HomeView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var changeImageButton: UIButton!

    var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()

    var clearButton: UIBarButtonItem? {
        set {
          self.navigationItem.leftBarButtonItem = newValue
        }
        get {
          return self.navigationItem.leftBarButtonItem
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Put it inside viewModel
        self.navigationItem.title = "Test"

        clearButton = UIBarButtonItem(title: "Clear",
                                      style: .plain,
                                      target: self,
                                      action: #selector(clearImage))
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("resources: \(RxSwift.Resources.total)")
    }

    private func setupBindings() {

        // View Model outputs to the View Controller
        viewModel.image
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)

        viewModel.image.subscribe(onNext: {[weak self] (image) in
            self?.updateUI(image: image)
        }).disposed(by: disposeBag)

        // View Controller UI actions to the View Model
        changeImageButton.rx.tap
            .debounce(1.0, scheduler: MainScheduler.instance)
            .bind(to: viewModel.changeImage)
            .disposed(by: disposeBag)
    }

    func updateUI(image: UIImage?) {
        // set image name to title
        self.navigationItem.title = image == nil ? "Pick image" : "Selected Image"
        // if there is image, enable clear image button
        clearButton?.isEnabled = image != nil
    }

    @objc func clearImage(){
        //imageVariable.value = nil
    }
}
