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
import RxDataSources

class ChangeImageController: UIViewController, ChangeImageView {

    //@IBOutlet var images: [UIButton]!
    @IBOutlet weak var collectionView: UICollectionView!

    let disposeBag = DisposeBag()
    var viewModel: ChangeImageViewModel!

    private var cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
    private var doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.leftBarButtonItem = cancelButton

        setupBindings()
    }

    func setupBindings() {
        // View Model outputs to the View Controller
        let configureCell = ChangeImageController.collectionViewDataSourceUI()
        let dataSource = RxCollectionViewSectionedReloadDataSource(configureCell: configureCell)
        Observable.just(viewModel.dummyImages)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // View Controller UI actions to the View Model inputs
        collectionView.rx.modelSelected(ImageItem.self)
            .debug("Image Item Selected.. ")
            .bind(to: viewModel.selectedItem)
            .disposed(by: disposeBag)

        doneButton.rx.tap
            .map { self.viewModel.selectedItem.value }
            .map { $0!.image }
            .bind(to: viewModel.done).disposed(by: disposeBag)

        cancelButton.rx.tap
            .bind(to: viewModel.cancel)
            .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // TODO: There is a memory leak, all resources are not disposed after Change Image module closed
        print("resources: \(RxSwift.Resources.total)")
    }
}

extension ChangeImageController {

        static func collectionViewDataSourceUI() -> (
            CollectionViewSectionedDataSource<ImageSection>.ConfigureCell) {
                return (
                    { (_, cv, ip, i) in
                        let cell = cv.dequeueReusableCell(withReuseIdentifier: "Cell", for: ip) as! ImageCell
                        cell.imageView?.image = i.image
                        return cell
                })
        }
}
