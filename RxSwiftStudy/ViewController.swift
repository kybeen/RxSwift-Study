//
//  ViewController.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 1/4/24.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        setupButton()
    }
    
    func setupButton() {
        let myButton = UIButton()
        myButton.setTitle("버튼", for: .normal)
        myButton.setTitleColor(.systemBlue, for: .normal)
        
        view.addSubview(myButton)
        myButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }


}

