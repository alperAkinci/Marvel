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

    //var onChangeImageSelect: ((UIImage?) -> ())?
    var onComicSelect: ((ComicList) -> ())?
    var imageVariable = Variable<UIImage?>(#imageLiteral(resourceName: "rxswift"))
    var onChangeImageSelect = PublishSubject<UIImage?>()

    let disposeBag = DisposeBag()

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

        self.navigationItem.title = "Test"

        clearButton = UIBarButtonItem(title: "Clear",
                                      style: .plain,
                                      target: self,
                                      action: #selector(clearImage))

        imageVariable.asObservable().subscribe(onNext: {[weak self] (image) in
            self?.imageView.image = image
        }).disposed(by: disposeBag)

        imageVariable.asObservable().subscribe(onNext: {[weak self] (image) in
            self?.updateUI(image: image)
        }).disposed(by: disposeBag)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("resources: \(RxSwift.Resources.total)")
    }

    func updateUI(image: UIImage?) {
        // set image name to title
        self.navigationItem.title = image == nil ? "Pick image" : "Selected Image"
        // if there is image, enable clear image button
        clearButton?.isEnabled = image != nil
    }

    @objc func clearImage(){
        imageVariable.value = nil
    }

    @IBAction func changeImage(_ sender: UIButton) {
        onChangeImageSelect.onNext(imageVariable.value)
    }
}
