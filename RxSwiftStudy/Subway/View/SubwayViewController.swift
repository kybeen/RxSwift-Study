//
//  SubwayViewController.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 1/30/24.
//

/**
 뷰 컨트롤러에서는
 - 뷰에 어떻게 보여지게 될 지
 - 데이터를 받아서 어떻게 화면에 뿌릴지
 등 뷰와 관련된 코드만 담는다.
 */

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class SubwayViewController: UIViewController {
    
    private let subwayView = SubwayView()
    private let viewModel = SubwayViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(subwayView)
        subwayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // MARK: - Observable 바인딩
        viewModel.arrivalInfoObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] arrivalInfoList in
                print(arrivalInfoList[0])
                let prevStation = self?.viewModel.stationDict[arrivalInfoList[0].prevStation]!
                let nextStation = self?.viewModel.stationDict[arrivalInfoList[0].nextStation]!
                let station = arrivalInfoList[0].station
                
                self?.subwayView.stationLabel.text = "\(prevStation!) ➡️ \(station) ➡️ \(nextStation!)"
                self?.subwayView.timeLabel.text =  "\(arrivalInfoList[0].restTime)초 남았습니다."
            })
            .disposed(by: disposeBag)
            
        subwayView.searchButton.addTarget(self, action: #selector(searchArrival), for: .touchUpInside)
    }
    
    @objc private func searchArrival() {
        viewModel.checkArrival(stationName: subwayView.stationField.text ?? "연신내")
    }
}



