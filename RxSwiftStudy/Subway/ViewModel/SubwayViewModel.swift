//
//  SubwayViewModel.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 2/6/24.
//

/**
 뷰모델에서는
 - 데이터에 대해 어떻게 로직이 처리되는지
 - 어떤 데이터를 보여줘야 하는지
 등 데이터 등과 관련된 로직에 대한 처리를 담는다.
 */

import Foundation

import RxSwift
import RxRelay

class SubwayViewModel {
    
    // MARK: - ArrivalInfo 배열 값이 변경될 때마다 받아오는 Observable
    lazy var arrivalInfoObservable = PublishRelay<[ArrivalInfo]>()
    
    func checkArrival(stationName: String) {
        
        _ = APIManager.fetchRealtimeArrivalRx(stationName: stationName)
            .map { data in
                let response = try! JSONDecoder().decode(ArrivalResponse.self, from: data)
                return response.realtimeArrivalList
            }
            .map { realtimeArrivals -> [ArrivalInfo] in
                var arrivals = [ArrivalInfo]()
                realtimeArrivals.enumerated().forEach { (_, item) in
                    let arrivalInfo = ArrivalInfo.fromArrivalResponseItems(item: item)
                    arrivals.append(arrivalInfo)
                }
                return arrivals
            }
            .take(1)
            .bind(to: arrivalInfoObservable)
    }
}
