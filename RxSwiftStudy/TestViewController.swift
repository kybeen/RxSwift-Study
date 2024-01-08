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
        return Observable.just("Hello World") // 📌 just() : 1개 값을 전달
    }
    
    // MARK: SYNC

    @objc private func onLoad() {
        testView.editView.text = ""
        self.testView.activityIndicator.startAnimating()
        
        // 2. Observable로 오는 데이터를 받아서 처리하는 방법
        downloadJSON(MEMBER_LIST_URL)
            .debug()
            .subscribe() { event in // subscribe에 의해 Disposable이 리턴 (이후 필요에 따라서 취소시켜준다.)
                switch event {
                case .next(let t):
                    print(t)
                    
                case .error(let err):
                    break
                    
                case .completed:
                    break
                    
                }
            }
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
