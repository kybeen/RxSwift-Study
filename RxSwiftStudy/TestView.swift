//
//  TestView.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 1/4/24.
//

import UIKit

import SnapKit

final class TestView: UIView {
    
    lazy var myButton: UIButton = {
        let button = UIButton()
        button.setTitle("버튼", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        addSubview(myButton)
        myButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - 프리뷰 canvas 세팅
import SwiftUI

struct TestViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = TestViewController
    func makeUIViewController(context: Context) -> TestViewController {
        return TestViewController()
    }
    func updateUIViewController(_ uiViewController: TestViewController, context: Context) {}
}
@available(iOS 13.0.0, *)
struct LoginViewPreview: PreviewProvider {
    static var previews: some View {
        TestViewControllerRepresentable()
    }
}
