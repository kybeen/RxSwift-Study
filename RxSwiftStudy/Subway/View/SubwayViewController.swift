//
//  SubwayViewController.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 1/30/24.
//

import UIKit

import SnapKit

final class SubwayViewController: UIViewController {
    
    private let subwayView = SubwayView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(subwayView)
        subwayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}



