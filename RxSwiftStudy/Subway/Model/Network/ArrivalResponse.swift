//
//  ArrivalResponse.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 2/6/24.
//

// MARK: - 네트워크 통신용 모델

import Foundation

/**
 ArrivalResponse
 - errorMessage: 에러메세지
 - realtimeArrivalList: 실시간 지하철 도착 정보 배열
 */
struct ArrivalResponse: Codable {
    let errorMessage: ErrorMessage
    let realtimeArrivalList: [RealtimeArrival]
}

/**
 "errorMessage":{
     "status":200,
     "code":"INFO-000",
     "message":"정상 처리되었습니다.",
     "link":"",
     "developerMessage":"",
     "total":8
 },
 */
struct ErrorMessage: Codable {
    let status: Int
    let code: String
    let message: String
    let link: String
    let developerMessage: String
    let total: Int
}

/**
 {
     "beginRow":null,
     "endRow":null,
     "curPage":null,
     "pageRow":null,
     "totalCount":8,
     "rowNum":1,
     "selectedCount":8,
     "subwayId":"1003",
     "subwayNm":null,
     "updnLine":"상행",
     "trainLineNm":"대화행 - 구파발방면",
     "subwayHeading":null,
     "statnFid":"1003000322",
     "statnTid":"1003000320",
     "statnId":"1003000321",
     "statnNm":"연신내",
     "trainCo":null,
     "trnsitCo":"2",
     "ordkey":"01000대화0",
     "subwayList":"1003,1006",
     "statnList":"1003000321,1006000614",
     "btrainSttus":"일반",
     "barvlDt":"0",
     "btrainNo":"3216",
     "bstatnId":"152",
     "bstatnNm":"대화",
     "recptnDt":"2024-02-06 14:28:40",
     "arvlMsg2":"연신내 도착",
     "arvlMsg3":"연신내",
     "arvlCd":"1"
 },
 */
struct RealtimeArrival: Codable {
    let beginRow: Int?
    let endRow: Int?
    let curPage: Int?
    let pageRow: Int?
    let totalCount: Int
    let rowNum: Int         // 몇번째 데이터인지 1~totalCount
    let selectedCount: Int
    let subwayId: String    // 지하철호선 ID
    let subwayNm: Int?
    let updnLine: String    // 상하행선구분
    let trainLineNm: String // 도착지방면 👉 목적지역 - 다음역
    let subwayHeading: Int?
    let statnFid: String    // 이전지하철역 ID
    let statnTid: String    // 다음지하철역 ID
    let statnId: String     // 지하철역 ID
    let statnNm: String     // 지하철역명
    let trainCo: String?
    let trnsitCo: String    // 환승노선수
    let ordkey: String      // 도착예정열차순번
    let subwayList: String  // 연계호선 ID (연계 지하철호선 ID 나열) 👉 "1003,1006"
    let statnList: String   // 연계지하철역 ID (현재 역의 호선별 역 ID 나열) 👉 "1003000321,1006000614"
    let btrainSttus: String // 열차종류 (급행, ITX, 일반, 특급)
    let barvlDt: String     // 열차도착예정시간 (단위: 초)
    let btrainNo: String    // 열차번호 (현재 운행하고 있는 호선별 열차번호)
    let bstatnId: String    // 종착지하철역 ID
    let bstatnNm: String    // 종착지하철역명
    let recptnDt: String    // 열차도착정보를 생성한 시각 👉 "2024-02-06 14:28:40"
    let arvlMsg2: String    // 첫번째도착메세지 (도착, 출발, 진입 등) 👉
    let arvlMsg3: String    // 두번째도착메세지 (종합운동장 도착, 12분 후 (광명사거리) 등)
    let arvlCd: String      // 도착코드 (0:진입, 1:도착, 2:출발, 3:전역출발, 4:전역진입, 5:전역도착, 99:운행중)
}
