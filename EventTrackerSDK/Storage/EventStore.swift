//
//  EventStore.swift
//  EventTrackerSDK
//
//  Created by 손지영 on 3/30/26.
//

import Foundation

protocol EventStore {
    func load() throws -> [TrackedEvent]
    func save(_ events: [TrackedEvent]) throws
}
