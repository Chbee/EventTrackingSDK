//
//  Tracker.swift
//  EventTrackerSDK
//
//  Created by 손지영 on 3/30/26.
//

import Foundation

public final class Tracker {
    public static var shared = Tracker()
    
    private init() {}
    
    private var isInitialized: Bool = false
    
    public func initialize() {
        /*
         필요 설정 등록
         */
        isInitialized = true
    }
    
    public func log(event: String, properties: [String:Any]? = nil) {
        guard isInitialized else {
            assertionFailure("[WARNING] SDK가 초기화되지 않았습니다.")
            return
        }
        
        // 실제 이벤트 수집 시작
    }
}

