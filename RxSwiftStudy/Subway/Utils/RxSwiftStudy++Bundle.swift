//
//  RxSwiftStudy++Bundle.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 2/6/24.
//

import Foundation

extension Bundle {
    
    var SUBWAY_API_KEY: String {
        // plist 파일 경로 불러오기
        guard let file = self.path(forResource: "Secrets", ofType: "plist") else { return "" }
        
        // plist를 딕셔너리로 받아오기
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        // 딕셔너리에서 값 찾기
        guard let key = resource["SUBWAY_API_KEY"] as? String else { return "" }
        
        return key
    }
}
