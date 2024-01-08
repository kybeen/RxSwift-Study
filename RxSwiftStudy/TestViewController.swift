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
//        return Observable.just("Hello World") // 📌 just() : 1개 값을 전달
//        return Observable.from(["Hello", "World"]) // 📌 from() : 배열의 각 원소를 전달
        
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

    // ✅ Operator : 데이터가 전달되는 중간에 처리해주는 메서드
    @objc private func onLoad() {
        testView.editView.text = ""
        self.testView.activityIndicator.startAnimating()
        
        downloadJSON(MEMBER_LIST_URL)
            .debug()
            .map { json in // 📌 .map() : 스위프트 고차함수 map과 동일하게 사용할 수 있는 operator
                json?.count ?? 0
            }
            .filter { cnt in cnt > 0 } // 📌 .filter() : 스위프트 고차함수 filter과 동일하게 사용할 수 있는 operator
            .map { "\($0)" }
            .observe(on: MainScheduler.instance) // 📌 observe(on:) : 특정 스케줄러에서 동작하도록 지정 (MainScheduler.instance : 메인스레드에서 동작)
            .subscribe(
                onNext: { json in
                    self.testView.editView.text = json
                    self.testView.activityIndicator.stopAnimating()
                }
            )
    }
}

//// MARK: - 프리뷰 canvas 세팅
//import SwiftUI
//
//struct TestViewControllerRepresentable: UIViewControllerRepresentable {
//    typealias UIViewControllerType = TestViewController
//    func makeUIViewController(context: Context) -> TestViewController {
//        return TestViewController()
//    }
//    func updateUIViewController(_ uiViewController: TestViewController, context: Context) {}
//}
//@available(iOS 13.0.0, *)
//struct LoginViewPreview: PreviewProvider {
//    static var previews: some View {
//        TestViewControllerRepresentable()
//    }
//}
