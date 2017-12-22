//
//  HomeCoordinator.swift
//  Marvel
//
//  Created by Alper Akinci on 23/11/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import Foundation
import RxSwift

final class HomeCoordinator: BaseCoordinator {

    // TODO: delete the variables
    // let changeImage = PublishSubject<UIImage?>()
    let completedImageChange = PublishSubject<UIImage?>()
    let disposeBag = DisposeBag()

    //if you are going to change different coordinator this property needed
    private let coordinatorFactory: CoordinatorFactory
    private let factory: HomeModuleFactory
    private let router: Router

    init(router: Router, factory: HomeModuleFactory, coordinatorFactory: CoordinatorFactory) {

        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        super.init()
    }

    override func start() {
        showHomeScreen()
    }

    //MARK: - Run controllers belong to homeCoordinator (Home Flow)

    private func showHomeScreen() {
        let viewModel = HomeViewModel()
        let viewController = factory.makeHomeOutput()
        viewController.viewModel = viewModel

        viewModel.showChangeImage
            .flatMap { [weak self] _ -> Observable<UIImage?> in
                guard let `self` = self else { return .empty() }
                return self.showChangeImage()
            }
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: viewModel.setImage)
            .disposed(by: disposeBag)

        router.setRootModule(viewController)
    }

    private func showChangeImage() -> Observable<UIImage?>{

        let viewModel = ChangeImageViewModel()
        let viewController = factory.makeChangeImageOutput()
        viewController.changeImageViewModel = viewModel

        viewController.completeSelectImage.asObservable()
            .subscribe(onNext: { [weak self] (image) in
                self?.router.popModule(animated: true)
            })
            .disposed(by: disposeBag)

        viewController.completeSelectImage.asObservable()
            .bind(to: completedImageChange)
            .disposed(by: disposeBag)

        router.push(viewController)
    }
}
