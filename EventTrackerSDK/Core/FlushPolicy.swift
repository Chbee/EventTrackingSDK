//
//  FlushPolicy.swift
//  EventTrackerSDK
//
//  Created by 손지영 on 3/30/26.
//

import Foundation

struct FlushPolicy {
    let maxBatchSize: Int
    let flushInterval: TimeInterval
    
    func shouldFlush(eventCount: Int) -> Bool {
        eventCount >= maxBatchSize
    }
}
