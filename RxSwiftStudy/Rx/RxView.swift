//
//  RxView.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 3/30/24.
//

import UIKit

import SnapKit

final class RxView: UIView {
    
    lazy var rxButton: UIButton = {
        let config = UIButton.Configuration.filled()
        let button = UIButton(configuration: config)
        button.setTitle("클릭미", for: .normal)
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
        
        addSubview(rxButton)
        rxButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    RxViewController()
}
