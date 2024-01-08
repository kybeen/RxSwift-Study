//
//  TestViewController.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 1/4/24.
//

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
