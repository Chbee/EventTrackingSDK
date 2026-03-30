//
//  EventSender.swift
//  EventTrackerSDK
//
//  Created by 손지영 on 3/30/26.
//

import Foundation

protocol EventSender {
    func send(events: [TrackedEvent], completion: @escaping (Result<Void, Error>) -> Void)
}
