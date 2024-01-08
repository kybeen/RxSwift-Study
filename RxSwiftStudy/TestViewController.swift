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
//    func downloadJSON(_ url: String) -> 나중에생기는데이터<String?> {
//        return 나중에생기는데이터 { f in
//            DispatchQueue.global().async {
//                let url = URL(string: url)!
//                let data = try! Data(contentsOf: url)
//                let json = String(data: data, encoding: .utf8)
//                
//                DispatchQueue.main.async {
//                    f(json)
//                }
//            }
//        }
//    }
    
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
        // 1. 비동기로 생기는 데이터를 Observable(나중에 생기는 데이터)로 감싸서 리턴하는 방법
        return Observable.create { emitter in
            let url = URL(string: url)!
            let task = URLSession.shared.dataTask(with: url) { data, _, err in
                guard err == nil else {
                    emitter.onError(err!) // 에러 발생 시 onError로 이벤트 전달
                    return
                }
                
                // 데이터가 있으면 onNext로 이벤트 전달
                if let dat = data, let json = String(data: dat, encoding: .utf8) {
                    emitter.onNext(json)
                }
                
                // 작업이 완료되면 onCompleted로 이벤트 전달
                emitter.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create() {
                // 취소 시 동작
                task.cancel()
            }
        }
        
        
//        return Observable.create() { f in
//            DispatchQueue.global().async {
//                let url = URL(string: url)!
//                let data = try! Data(contentsOf: url)
//                let json = String(data: data, encoding: .utf8)
//                
//                DispatchQueue.main.async {
//                    f.onNext(json)
//                    f.onCompleted() // completed, error 이벤트 시 subscribe에 대한 클로저가 사라지기 때문에 값 전달 후 completed를 시켜주면서 순환 참조를 방지해줄 수 있다.
//                }
//            }
//            
//            return Disposables.create()
//        }
    }
    
    // MARK: SYNC

    @objc private func onLoad() {
        testView.editView.text = ""
        self.testView.activityIndicator.startAnimating()
        
//        let json: 나중에생기는데이터<String?> = downloadJSON(MEMBER_LIST_URL)
//        
//        json.나중에오면 { json in
//            self.testView.editView.text = json
//            self.testView.activityIndicator.stopAnimating()
//        }
        
        // 2. Observable로 오는 데이터를 받아서 처리하는 방법
        downloadJSON(MEMBER_LIST_URL)
            .debug()
            .subscribe() { event in // subscribe에 의해 Disposable이 리턴 (이후 필요에 따라서 취소시켜준다.)
                switch event {
                case .next(let json):
                    DispatchQueue.main.async {
                        self.testView.editView.text = json
                        self.testView.activityIndicator.stopAnimating()
                    }
                    
                case .error(let err):
                    break
                    
                case .completed:
                    break
                    
                }
            }
        
//        downloadJSON(MEMBER_LIST_URL)
//            .debug() // 데이터가 전달되는 동안 어떤 데이터가 전달되는지 콘솔에 찍힘
//            .subscribe { event in // 비동기적으로 받아온 값(Observable)이 오면 처리되는 부분
//                switch event {
//                case .next(let json): // 📌데이터가 전달될 때
//                    DispatchQueue.main.async {
//                        self.testView.editView.text = json
//                        self.testView.activityIndicator.stopAnimating()
//                    }
//                case .completed: // 📌데이터가 다 전달되고 끝났을 때
//                    break
//                case .error: // 📌에러났을 때
//                    break
//                }
//            }
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
