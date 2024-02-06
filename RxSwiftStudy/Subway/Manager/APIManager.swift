//
//  APIManager.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 2/6/24.
//

// MARK: - API 호출 관련 클래스

import Foundation

import RxSwift

let SUBWAY_API_KEY = ""
let REQUEST_START_INDEX = 0
let REQUEST_END_INDEX = 15

class APIManager {
    
    // MARK: - API 호출 메서드
    static func fetchRealtimeArrival(stationName: String, onComplete: @escaping (Result<Data, Error>) -> Void) {
        let ArrivalUrl = "http://swopenAPI.seoul.go.kr/api/subway/\(SUBWAY_API_KEY)/json/realtimeStationArrival/\(REQUEST_START_INDEX)/\(REQUEST_END_INDEX)/\(stationName)"
        
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
