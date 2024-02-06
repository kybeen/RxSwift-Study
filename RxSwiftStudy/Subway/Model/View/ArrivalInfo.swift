//
//  ArrivalInfo.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 2/6/24.
//

// MARK: - 뷰를 위한 모델

import Foundation

struct ArrivalInfo {
    var restTime: Int       // 남은 시간 (단위: 초)
    var prevStation: String // 이전역
    var nextStation: String // 다음역
    var station: String     // 현재역
}

extension ArrivalInfo {
    static func fromArrivalResponseItems(item: RealtimeArrival) -> ArrivalInfo {
        // TODO: - 이전역, 다음역 ID -> 이름 파싱 작업 필요
        return ArrivalInfo(restTime: Int(item.barvlDt)!, prevStation: item.statnFid, nextStation: item.statnTid, station: item.statnNm)
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
