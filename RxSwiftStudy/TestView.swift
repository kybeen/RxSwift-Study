//
//  TestView.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 1/4/24.
//

import UIKit

import SnapKit

final class TestView: UIView {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .white
        return indicator
    }()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0"
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    lazy var loadButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOAD", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    lazy var editView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .lightGray
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        addSubview(timerLabel)
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        addSubview(loadButton)
        loadButton.snp.makeConstraints { make in
            make.top.equalTo(timerLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
            make.height.equalTo(50)
        }
        
        addSubview(editView)
        editView.snp.makeConstraints { make in
            make.top.equalTo(loadButton.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerY.equalTo(loadButton)
            make.right.equalTo(loadButton).offset(-20)
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
struct TestViewPreview: PreviewProvider {
    static var previews: some View {
        TestViewControllerRepresentable()
    }
}
