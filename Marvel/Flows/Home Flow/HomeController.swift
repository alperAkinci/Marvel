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

    var onComicSelect: ((ComicList) -> ())?
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        print("1 - Creating Observables")

        let apple = "Apple"
        let orange = "Orange"
        let cherry = "Cherry"

        let observable = Observable.of(apple, orange, cherry)

        print("\n - Printing Events")
        observable
            .subscribe { (event) in
                print(event)
            }
            .disposed(by: disposeBag)

        print("\n - Printing Only Element of Events")
        let _ = observable.subscribe { (event) in
            if let element = event.element {
                print(element)
            }
        }

        print("\n - Creating Empty Observables")

        let emptyObservable = Observable<Void>.empty()

        let _ = emptyObservable.subscribe(
            onNext: { (element) in
                print(element)},
            onCompleted: {
                print("Completed")
        })
        print("\n - Creating Range Observables")
        let rangeObservable = Observable<Int>.range(start: 1, count: 10)

        let _ = rangeObservable.subscribe(
            onNext: { (element) in
                print(element)},
            onCompleted: {
                print("Completed")
        })

        print("\n - Disposing Observables")
        // explicitly cancel a subscription
        let disposableObservable = Observable.of(1,2,3)
        let subscriber = disposableObservable.subscribe { (event) in
        }
        subscriber.dispose()

        /**
         Disposable Bags :
         A dispose bag holds disposables — typically added using the .addDisposableTo() method — and will call dispose() on each one when the dispose bag is about to be deallocated.

         */
        let observableWithDisposableBag = Observable.of(1,2,3)
        observableWithDisposableBag
            .subscribe(onNext: { print($0)})
            .disposed(by: disposeBag)


        print("\n - Event specified observable (create operator)")
        /**
         Another way to specify all events that an observable will emit to subscribers is by using the create operator.
         */
        enum MyError:Error {
            case testError
        }

        let createObservable = Observable<String>.create { (observer) -> Disposable in
            observer.onNext("Start working...")
            //observer.onError(MyError.testError)
            observer.onCompleted()
            observer.onNext("Leave work.")
            return Disposables.create()
        }

        createObservable.subscribe(
            onNext: { print($0) },
            onError: { print($0) },
            onCompleted: { print("Completed")}) {
                print("Disposed")
            }.disposed(by: disposeBag)

        print("\n - Observable factory")

        var temp = false
        let factory = Observable<String>.deferred {
            temp = !temp
            if temp {
                return Observable<String>.create({ (observer) -> Disposable in
                    observer.onNext("Black")
                    return Disposables.create()
                })
            }else {
                return Observable.of("White", "Orange", "Red")
            }
        }

        for _ in 1...10 {
            factory.subscribe(onNext: { (color) in
                print(color, terminator: "")
            }).disposed(by: disposeBag)
            print()
        }

        print("\n2 - Subjects")

        /**
         Common need when developing apps is to manually add new values onto an observable at runtime that will then be emitted to subscribers. What you want is something that can act as both an observable and as an observer. And that something is called a Subject.
        */

        print("\n - Publish Subjects")
        let publishSubject = PublishSubject<String>()

        // Behaving as observer - receives events
        publishSubject.onNext("Hey Listen me! Are you there?")

        // Behaving as observable - be subscribed to
        publishSubject.subscribe(onNext: { (message) in
            print(message)
        }).disposed(by: disposeBag)

        // Result: The subject received .next events, and each time it received an event, it turned around and emitted it to its subscriber.
        publishSubject.onNext("I am publishSubject. When you subscribe me, you will only get the values that were emitted after the subscription.")

        print("\n - Behaviour Subjects")
        let behaviourSubject = BehaviorSubject<String>(value: "First Message")

        behaviourSubject.onNext("Second Message - I am behaviourSubject.When you subscribe me, you will get the latest value emitted by the Subject, and then the values emitted after the subscription.")

        print("first behaviour subject:")
        behaviourSubject.subscribe(onNext: { (message) in
            print(message) // Will only print second event
        }).disposed(by: disposeBag)

        behaviourSubject.onNext("Third Message")

        print("second behaviour subject:")
        behaviourSubject.subscribe(onNext: { (message) in
            print(message) // Will only print second event
        }).disposed(by: disposeBag)

        /**
         NOTE:
         - Since BehaviorSubject always emits the latest element, you can't create one without providing a default initial value. If you can't provide a default initial value at creation time, that probably means you need to use a PublishSubject instead.
        */
    }
}
