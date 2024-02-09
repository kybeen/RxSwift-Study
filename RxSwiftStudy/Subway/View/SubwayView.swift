//
//  SubwayView.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 1/30/24.
//

import UIKit

import SnapKit

final class SubwayView: UIView {
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 역이 어디신가요?"
        label.font = .systemFont(ofSize: 35, weight: .bold)
        return label
    }()
    
    lazy var stationField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "역을 입력해주세요."
        textField.font = .systemFont(ofSize: 25)
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
    
    // MARK: - 결과 확인 관련 스택 뷰
    lazy var resultStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 50
        return stackView
    }()
    
    lazy var stationLabel: UILabel = {
        let label = UILabel()
        label.text = "이전역 ➡️ 현재역 ➡️ 다음역"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00초 남았습니다."
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        return label
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
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        addSubview(stationField)
        stationField.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(stationField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
        }
        
        addSubview(resultStackView)
        resultStackView.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        resultStackView.addArrangedSubview(stationLabel)
        resultStackView.addArrangedSubview(timeLabel)
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
