//
//  TrackedEvent.swift
//  EventTrackerSDK
//
//  Created by 손지영 on 3/30/26.
//

import Foundation

struct TrackedEvent: Codable, Equatable {
    let eventID: String
    let name: String
    let properties: [String:String]
    let createdAt: Date
    let sequence: Int
}
