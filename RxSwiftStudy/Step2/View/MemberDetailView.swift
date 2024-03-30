//
//  MemberDetailView.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 1/8/24.
//

import UIKit

final class MemberDetailView: UIView {
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Detail"
        label.textColor = .black
        label.font = .systemFont(ofSize: 40, weight: .semibold)
        return label
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = "#ID"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .black
        label.font = .systemFont(ofSize: 35, weight: .semibold)
        return label
    }()
    
    lazy var jobLabel: UILabel = {
        let label = UILabel()
        label.text = "Job"
        label.textColor = .black
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    
    lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "AGE"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.size.equalTo(350)
        }
        
        addSubview(idLabel)
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        
        addSubview(jobLabel)
        jobLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(110)
            make.centerX.equalToSuperview()
        }
        
        addSubview(ageLabel)
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(170)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - 프리뷰 canvas 세팅
@available(iOS 17.0.0, *)
#Preview {
    MemberDetailViewController()
}
