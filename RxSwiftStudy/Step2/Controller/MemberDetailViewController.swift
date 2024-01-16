//
//  MemberDetailViewController.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 1/8/24.
//

import UIKit

final class MemberDetailViewController: UIViewController {
    
    private let memberDetailView = MemberDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(memberDetailView)
        memberDetailView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
