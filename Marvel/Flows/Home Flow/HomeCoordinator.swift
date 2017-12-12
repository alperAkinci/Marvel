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
            guard let image = image else{ return }
            self?.showChangeImage()
        }).disposed(by: disposeBag)
    }

    override func start() {
        showComicList()
    }

    //MARK: - Run controllers belong to homeCoordinator (Home Flow)

    private func showComicList() {

        let comicsOutput = factory.makeHomeOutput()

        // if comic selected, show detail screen
        comicsOutput.onComicSelect = { [weak self] (item) in
            //self?.showComicDetail(item)
        }

        comicsOutput.onChangeImageSelect.asObservable()
            .bind(to: changeImage)
            .disposed(by: disposeBag)

//        comicsOutput.onChangeImageSelect = { [weak self] (image) in
//            self?.showChangeImage()
//        }

//        imageSelected.asObservable()
//            .bind(to: comicsOutput.imageVariable)
//            .disposed(by: disposeBag)

//       Creating new comic
//        comicsOutput.onCreateItem = { [weak self] in
//            self?.runCreationFlow()
//        }
        router.setRootModule(comicsOutput)
    }

    private func showChangeImage() {

        let changeImageOutput = factory.makeChangeImageOutput()

        changeImageOutput.onCompleteSelectImage = {[weak self] in
            self?.router.popModule(animated: true)
        }

//        changeImageOutput.selectedImageSubject
//            .asObservable()
//            .bind(to: imageSelected)
//            .disposed(by: disposeBag)

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
