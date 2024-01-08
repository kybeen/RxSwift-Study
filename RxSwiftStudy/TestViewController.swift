//
//  TestViewController.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 1/4/24.
//

/**
 💡 비동기로 값을 받아오면 completion이 아닌 `리턴값`으로 처리하도록 하고 싶다!!! 👉 다양한 유틸리티들이 생겨남
 - ✅ Primise : PromiseKit
 - ✅ Bolt
 - **✅ RxSwift**
    - 나중에생기는데이터: `Observable`
    - 나중에오면: `subscribe()`
 */

/**
 ✅ `Observable`의 생명주기
 1. Create
 2. Subscribe (Observable은 subscribe가 되어야 동작함)
 3. onNext
 -------------- 끝 -------------- (동작이 끝난 Observable은 재사용할 수 X)
 4. onCompleted   /   onError
 5. Disposed
 */

/**
 💡 **다양한 `Operator`들**
 - `just()` : 한 개 데이터 전달을 간단하게
 - `from()` : 배열의 각 원소를 전달
 - `subscribe(onNext:onError:onComplete)` : subscribe()의 이벤트 처리를 간단하게
 - `observe(on:)` : 특정 쓰레드에서 동작하도록 지정
 - `subscribe(on:)` : Observable의 첫 번째 동작을 어느 쓰레드에서 진행할 지 지정
 - `map()`, `filter()` : 스위프트 고차함수와 동일하게 사용
 - `merge()` : 여러 개의 Observable들을 묶어서 하나의 Observable로
 - `zip()` : Observable 별로 생성되는 데이터들을 쌍으로 묶어서 방출
 - `combineLatest()` : 가장 최근에 방출된 데이터끼리 묶어서 방출
 */

import UIKit

import RxCocoa
import RxSwift
import SnapKit

let MEMBER_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"

class 나중에생기는데이터<T> {
    private let task: (@escaping (T) -> Void) -> Void
    
    // 생성될 때 클로저를 받아서 가지고 있다가
    init(task: @escaping (@escaping (T) -> Void) -> Void) {
        self.task = task
    }
    
    // 나중에오면() 메서드가 호출되면 받아서 가지고 있던 task 클로저를 실행하면서, 지금 들어온 클로저 f를 전달해준다.
    func 나중에오면(_ f: @escaping (T) -> Void) {
        task(f)
    }
}

final class TestViewController: UIViewController {
    
    private let testView = TestView()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(testView)
        testView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        testView.loadButton.addTarget(self, action: #selector(onLoad), for: .touchUpInside)
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.testView.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }
    
    func downloadJSON(_ url: String) -> Observable<String?> {
        
        return Observable.create { emitter in
            let url = URL(string: url)!
            let task = URLSession.shared.dataTask(with: url) { data, _, err in
                guard err == nil else {
                    emitter.onError(err!)
                    return
                }
                
                if let dat = data, let json = String(data: dat, encoding: .utf8) {
                    emitter.onNext(json)
                }
                
                emitter.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    // MARK: SYNC

    @objc private func onLoad() {
        testView.editView.text = ""
        self.testView.activityIndicator.startAnimating()
        
        let jsonObservable = downloadJSON(MEMBER_LIST_URL)
        let helloObservable = Observable.just("Hello World")
        
        // 📌 zip() : Observable 별로 생성되는 데이터들을 순서대로 쌍으로 묶어서 방출
        Observable.zip(jsonObservable, helloObservable) { $1 + "\n" + $0! }
            .debug()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { json in
                    self.testView.editView.text = json
                    self.testView.activityIndicator.stopAnimating()
                }
            )
            .disposed(by: disposeBag)
    }
}
