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
    
    private var dispatcher: EventDispatcher?
    private var isInitialized: Bool = false
    
    public func initialize() {
        /*
         필요 설정 등록
         */
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = directory.appendingPathComponent("tracked_events.json")
        
        let store = FileEventStore(fileURL: fileURL)
        let sender = MockEventSender()
        let flushPolicy = FlushPolicy(maxBatchSize: 5, flushInterval: 5)
        
        dispatcher = EventDispatcher(store: store, sender: sender, flushPolicy: flushPolicy)
        isInitialized = true
    }
    
    public func log(event: String, properties: [String:String] = [:]) {
        guard isInitialized else {
            assertionFailure("[WARNING] SDK가 초기화되지 않았습니다.")
            return
        }
        
        dispatcher?.log(name: event, properties: properties)
    }
    
    public func sendStoredEvents() {
        dispatcher?.flush()
    }
}
