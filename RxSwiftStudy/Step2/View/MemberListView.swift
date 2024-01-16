//
//  MemberListView.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 1/8/24.
//

import UIKit

final class MemberListView: UIView {
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.text = "Members"
        title.textColor = .black
        title.font = .systemFont(ofSize: 40, weight: .bold)
        return title
    }()
    
    lazy var memberListTableView: UITableView = {
        let tableView = UITableView()
        return tableView
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
        addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(12)
        }
        
        addSubview(memberListTableView)
        memberListTableView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.bottom.equalToSuperview()
        }
    }
}
