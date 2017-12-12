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

    let changeImage = PublishSubject<UIImage?>()
    let completedImageChange = PublishSubject<UIImage?>()
    let disposeBag = DisposeBag()

    private let factory: HomeModuleFactory

    //if you are going to change different coordinator this property needed
    private let coordinatorFactory: CoordinatorFactory

    private let router: Router

    init(router: Router, factory: HomeModuleFactory, coordinatorFactory: CoordinatorFactory) {

        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        super.init()

        changeImage.subscribe(onNext: {[weak self] (image) in
            let viewModel = ChangeImageViewModel(image: image)
            self?.showChangeImage(with: viewModel)
        }).disposed(by: disposeBag)

    }

    override func start() {
        showComicList()
    }

    //MARK: - Run controllers belong to homeCoordinator (Home Flow)

    private func showComicList() {

        let comicsOutput = factory.makeHomeOutput()
        comicsOutput.onChangeImageSelect.asObservable()
            .bind(to: changeImage)
            .disposed(by: disposeBag)

        completedImageChange.asObservable()
            .bind(to: comicsOutput.imageVariable)
            .disposed(by: disposeBag)

        router.setRootModule(comicsOutput)
    }

    private func showChangeImage(with viewModel: ChangeImageViewModel) {

        let changeImageOutput = factory.makeChangeImageOutput()
        changeImageOutput.changeImageViewModel = viewModel

        changeImageOutput.completeSelectImage.asObservable()
            .subscribe(onNext: { [weak self] (image) in
                self?.router.popModule(animated: true)
            })
            .disposed(by: disposeBag)

        changeImageOutput.completeSelectImage.asObservable()
            .bind(to: completedImageChange)
            .disposed(by: disposeBag)

        router.push(changeImageOutput)
    }

/// - Comic Detail Screen
//    private func showComicDetail(_ comic: ComicList) {
//
//        let itemDetailFlowOutput = factory.makeItemDetailOutput(item: item)
//        router.push(itemDetailFlowOutput)
//    }


// MARK: - Run coordinators (switch to another flow)


// - Creating Flow for comic detail
//    private func runCreationFlow() {
//
//        let (coordinator, module) = coordinatorFactory.makeItemCreationCoordinatorBox()
//        coordinator.finishFlow = { [weak self, weak coordinator] item in
//
//            self?.router.dismissModule()
//            self?.removeDependency(coordinator)
//            if let item = item {
//                self?.showItemDetail(item)
//            }
//        }
//        addDependency(coordinator)
//        router.present(module)
//        coordinator.start()
//    }
}
