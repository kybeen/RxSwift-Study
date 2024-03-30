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
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(rxView)
        rxView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        /*
         - @objc 메서드를 addTarget 하는 대신 이렇게 사용할 수 있다.
         - .subscribe() 메서드를 통해 Observable를 구독하면 메서드 내부에서 Observer를 자체적으로 생성하여 파라미터의 클로저를 통해 Observable이 방출하는 item을 받게 된다.
         */
        rxView.rxButton.rx.tap
            .subscribe(onNext: {
                print("Observable이 항목을 방출")
            }, onError: { error in
                print("에러 발생")
            }, onCompleted: {
                print("해당 이벤트가 종료됨")
            })
            .disposed(by: disposeBag)
        
    }
}

@available(iOS 17.0, *)
#Preview {
    RxViewController()
}
