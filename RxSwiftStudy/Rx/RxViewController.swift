//
//  RxViewController.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 3/30/24.
//

import UIKit

import RxCocoa
import RxSwift

final class RxViewController: UIViewController {
    
    private let rxView = RxView()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(rxView)
        rxView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        /*
         - https://babbab2.tistory.com/187
         - just, of, from, create
         */
//        let observable = Observable.just([1,2,3,4]) // 1개의 item만 방출하는 Observable Sequence 생성
//        let observable = Observable.of([1,2], [3,4], [5,6]) // 1개 이상의 item을 방출하는 Observable Sequence 생성
//        let observable = Observable.from([1, 2, 3, 4, 5]) // 파라미터로 하나의 배열만 받을 수 있고, 그 배열의 요소들을 순서대로 방출하는 Observable Sequence를 생성
//        let observable = Observable<String>.create { observer in // Observer를 매개변수로 받는 클로저를 파라미터로 전달받는 Observable Sequence를 생성
//            observer.onNext("1번째 방출")
//            observer.onNext("2번째 방출")
//            observer.onCompleted() // 이벤트 종료
//            observer.onNext("3번째 방출") // 앞에서 이벤트가 종료되었기 때문에 해당 이벤트는 방출되지x
//            return Disposables.create() // 반드시 Disposable을 생성해서 리턴해줘야 함
//        }
        /*
         - https://babbab2.tistory.com/188
         - empty, never, range, interval, timer, defer
         */
//        let observable = Observable<Void>.empty() // 어떠한 item도 방출(emit)하지 않고, 즉시 onCompleted()를 호출하여 정상적으로 종료되는 Observable을 생성
//        let observable = Observable<Void>.never() // 어떠한 item도 방출(emit)하지 않고, 스트림이 종료되지도 않는 Observable을 생성
//        let observable = Observable.range(start: 0, count: 5) // 특정 범위의 “정수”를 순서대로 방출하는 Observable을 생성
//        let observable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance) // 주어진 시간 간격으로 순서대로 정수를 방출하는 Observable을 생성
//        let observable = Observable<Int>.timer(.seconds(3), scheduler: MainScheduler.instance) // 주어진 딜레이 시간 이후에 특정 item을 방출하는 Observable을 생성
//        let observable = Observable<Int>.timer(
//            .seconds(3),
//            period: .seconds(1), // 지연이 끝난 이후 다음 값이 생성되는 주기
//            scheduler: MainScheduler.instance
//        )
//        observable.subscribe(
//            onNext: { data in
//                print(data)
//            },
//            onCompleted: {
//                print("Completed!!")
//            },
//            onDisposed: {
//                print("Disposed!!")
//            })
        
//        /*
//         - https://babbab2.tistory.com/186
//         */
//        let rxDisposable = rxView.rxButton.rx.tap
//            .subscribe(onNext: {
//                print("버튼 눌림")
//            }, onDisposed: {
//                // rxButton에 대한 구독이 해제될 때 실행
//                print("Observable이 Dispose됨 ☠️")
//            })
//        rxView.rxDieButton.rx.tap
//            .subscribe(onNext: {
//                print("버튼 구독 해제!!")
//                rxDisposable.dispose()
//            })
        
//        /*
//         - https://babbab2.tistory.com/185
//         - @objc 메서드를 addTarget 하는 대신 이렇게 사용할 수 있다.
//         - .subscribe() 메서드를 통해 Observable를 구독하면 메서드 내부에서 Observer를 자체적으로 생성하여 파라미터의 클로저를 통해 Observable이 방출하는 item을 받게 된다.
//         */
//        rxView.rxButton.rx.tap
//            .subscribe(onNext: {
//                print("Observable이 항목을 방출")
//            }, onError: { error in
//                print("에러 발생")
//            }, onCompleted: {
//                print("해당 이벤트가 종료됨")
//            })
//            .disposed(by: disposeBag)
        
    }
}

@available(iOS 17.0, *)
#Preview {
    RxViewController()
}
