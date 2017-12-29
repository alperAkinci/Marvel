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
                return self.showChangeImage(with: ImageItem(image: #imageLiteral(resourceName: "rxswift")))
            }
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: viewModel.setImage)
            .disposed(by: disposeBag)

        router.setRootModule(viewController)
    }

    private func showChangeImage(with imageItem: ImageItem) -> Observable<UIImage?>{

        enum ChangeImageModuleResult{
            case done(UIImage)
            case cancel
        }

        // Create controller
        let viewController = factory.makeChangeImageOutput()

        // Set view model
        let viewModel = ChangeImageViewModel(with: imageItem)
        viewController.viewModel = viewModel

        let cancel = viewModel.didCancel.map { _  in
            ChangeImageModuleResult.cancel
        }

        let done = viewModel.didDone.map {
            ChangeImageModuleResult.done($0)
        }

        router.push(viewController)

        return Observable.merge(cancel, done)
            .take(1)
            .do(onNext: { [weak self] _ in self?.router.popModule(animated: true)})
            .map({ (result) in
                switch result {
                case .cancel: return nil
                case .done(let image): return image
                }
            })
    }
}
