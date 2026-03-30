//
//  MockEventSender.swift
//  EventTrackerSDK
//
//  Created by 손지영 on 3/30/26.
//

import Foundation


final class MockEventSender: EventSender {
    func send(events: [TrackedEvent], completion: @escaping (Result<Void, any Error>) -> Void) {
        let shouldSucceed = Int.random(in: 0..<100) < 70
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            if shouldSucceed {
                print("[LOG] Send Events: \(events.map(\.eventID))")
                completion(.success(()))
            } else {
                print("[ERROR] Failed to send events: \(events.map(\.eventID))")
                completion(.failure(NetworkError.failedToFetch))
            }
        }
    }
}
