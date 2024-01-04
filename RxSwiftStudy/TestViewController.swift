//
//  TestViewController.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 1/4/24.
//

import UIKit

import RxSwift
import SnapKit

final class TestViewController: UIViewController {
    
    private let testView = TestView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(testView)
        testView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        testView.myButton.addTarget(
            self,
            action: #selector(buttonPressed),
            for: .touchUpInside
        )
    }

    @objc private func buttonPressed() {
        print("버튼 클릭")
    }
}
