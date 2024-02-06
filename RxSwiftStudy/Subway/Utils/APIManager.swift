//
//  APIManager.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 2/6/24.
//

// MARK: - API 호출 관련 클래스

import Foundation

import RxSwift

let REQ_START_IDX = 0
let REQ_END_IDX = 15

class APIManager {
    
    // MARK: - API 호출 메서드
    static func fetchRealtimeArrival(stationName: String, onComplete: @escaping (Result<Data, Error>) -> Void) {
        let ArrivalUrl = "http://swopenAPI.seoul.go.kr/api/subway/\(Bundle.main.SUBWAY_API_KEY)/json/realtimeStationArrival/\(REQ_START_IDX)/\(REQ_END_IDX)/\(stationName)"
        print("요청 URL: \(ArrivalUrl)")
        
        URLSession.shared.dataTask(with: URL(string: ArrivalUrl)!) { (data, response, error) in
            if let error = error {
                onComplete(.failure(error))
            }
            guard let data = data else {
                let httpResponse = response as! HTTPURLResponse
                onComplete(.failure(NSError(domain: "no data",
                                            code: httpResponse.statusCode,
                                            userInfo: nil)))
                return
            }
            onComplete(.success(data))
        }.resume()
    }
    
    // MARK: - RxSwift로 감싼 API 호출 메서드
    static func fetchRealtimeArrivalRx(stationName: String) -> Observable<Data> {
        return Observable.create() { emitter in
            
            fetchRealtimeArrival(stationName: stationName) { result in
                switch result {
                case .success(let data):
                    emitter.onNext(data)
                    emitter.onCompleted()
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
