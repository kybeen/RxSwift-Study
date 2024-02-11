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
    
    lazy var subwayDict = [String: String]()     // [호선ID : 호선이름]
    lazy var stationDict = [String: String]()    // [역ID : 역이름]
    
    // MARK: - ArrivalInfo 배열 값이 변경될 때마다 받아오는 Observable
    lazy var arrivalInfoObservable = PublishRelay<[ArrivalInfo]>()
    
    init() {
        loadCSV()
    }
    
    // MARK: - 실시간 도착 지하철 정보를 요청하는 메서드
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
    
    // MARK: - CSV 파일을 불러와 역과 호선의 ID-이름 쌍에 대한 딕셔너리를 만들어주는 메서드
    func loadCSV() {
        do {
            let path = Bundle.main.path(forResource: "Station_Info", ofType: "csv")!
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            
            let dataEncoded = String(data: data, encoding: .utf8)!
            
            var dataArr = dataEncoded.components(separatedBy: "\n")
            dataArr.removeFirst()
            dataArr.removeLast()
            for row in dataArr {
                let rowData = row.components(separatedBy: ",")[0..<4]
                let subwayID = rowData[0]       // 호선ID
                let stationID = rowData[1]      // 역ID
                let stationName = rowData[2]    // 역이름
                let subwayName = rowData[3]     // 호선이름
                
                subwayDict[subwayID] = subwayName
                stationDict[stationID] = stationName
            }
        } catch {
            print("Failed to load Station_Info,csv")
        }
    }
}
