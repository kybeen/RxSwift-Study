//
//  ArrivalInfo.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 2/6/24.
//

// MARK: - 뷰를 위한 모델

import Foundation

// 지하철 도착 정보
struct ArrivalInfo {
    var restTime: RestTimeSecond    // 남은 시간 (단위: 초)
    var prevStation: String         // 이전역
    var nextStation: String         // 다음역
    var station: String             // 현재역
}

// 남은 시간
struct RestTimeSecond: CustomStringConvertible {
    var second: Int
    
    var description: String {
        return "\(second/60)분\(second%60)초"
    }
}

extension ArrivalInfo {
    
    // API로부터 실시간 도착 정보 응답을 받은 뒤, RealtimeArrival 값을 기반으로 ArrivalInfo를 만들어 리턴해주는 타입 메서드
    static func fromArrivalResponseItems(item: RealtimeArrival) -> ArrivalInfo {
        return ArrivalInfo(
            restTime: RestTimeSecond(second: Int(item.barvlDt)!),
            prevStation: item.statnFid,
            nextStation: item.statnTid,
            station: item.statnNm
        )
    }
}




//enum SubwayLine: String {
//    case 1001 = "1호선"
//    case 1002 = "2호선"
//    case 1003 = "3호선"
//    case 1004 = "4호선"
//    case 1005 = "5호선"
//    case 1006 = "6호선"
//    case 1007 = "7호선"
//    case 1008 = "8호선"
//    case 1009 = "9호선"
//    case 1063 = "경의중앙선"
//    case 1065 = "공항철도"
//    case 1067 = "경춘선"
//    case 1075 = "수인분당선"
//    case 1077 = "신분당선"
//    case 1081 = "경강선"
//    case 1092 = "우이신설선"
//    case 1093 = "서해선"
//}
