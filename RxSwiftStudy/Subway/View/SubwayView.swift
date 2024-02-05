//
//  SubwayView.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 1/30/24.
//

import UIKit

import SnapKit

final class SubwayView: UIView {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 역이 어디신가요?"
        label.font = .systemFont(ofSize: 40, weight: .bold)
        return label
    }()
    
    lazy var stationField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "역을 입력해주세요."
        textField.font = .systemFont(ofSize: 30)
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.gray()
        var titleAttr = AttributedString.init("검색")
        config.attributedTitle = titleAttr
        
        button.configuration = config
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        stackView.addArrangedSubview(headerLabel)
        stackView.addArrangedSubview(stationField)
        stackView.addArrangedSubview(searchButton)
        
        searchButton.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        
    }
}

// MARK: - 프리뷰 canvas 세팅
import SwiftUI

struct SubwayViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = SubwayViewController
    func makeUIViewController(context: Context) -> SubwayViewController {
        return SubwayViewController()
    }
    func updateUIViewController(_ uiViewController: SubwayViewController, context: Context) {}
}
@available(iOS 13.0.0, *)
struct SubwayViewViewPreview: PreviewProvider {
    static var previews: some View {
        SubwayViewControllerRepresentable()
    }
}
