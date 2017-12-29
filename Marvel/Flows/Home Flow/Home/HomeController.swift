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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("resources: \(RxSwift.Resources.total)")
    }

    private func setupBindings() {

        // View Model outputs to the View Controller
        viewModel.imageSelected
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)

        changeImageButton.rx.tap
            .debounce(1.0, scheduler: MainScheduler.instance)
            .bind(to: self.viewModel.changeImage)
            .disposed(by: disposeBag)
    }
}
