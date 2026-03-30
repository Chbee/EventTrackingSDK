//
//  EventDispatcher.swift
//  EventTrackerSDK
//
//  Created by 손지영 on 3/30/26.
//

import Foundation

final class EventDispatcher {
    private let queue = DispatchQueue(label: "com.example.event-dispatcher")
    private let store: EventStore
    private let flushPolicy: FlushPolicy
    
    private var events: [TrackedEvent] = []
    private var sequence: Int = 0
    private var isFlushing = false
    
    init(store: EventStore, flushPolicy: FlushPolicy) {
        self.store = store
        self.flushPolicy = flushPolicy
        
        queue.async {
            self.restoreEvents()
        }
    }
    
    // 운영 중 이벤트 입력
    func log(name: String, properties: [String: String]) {
        queue.async {
            self.sequence += 1
            
            let event = TrackedEvent(
                eventID: UUID().uuidString,
                name: name,
                properties: properties,
                createdAt: Date(),
                sequence: self.sequence
            )
            
            self.events.append(event)
            self.persist()
            
            if self.flushPolicy.shouldFlush(eventCount: self.events.count) {
                self.flush()
            }
        }
    }
    
    func flush() {
        queue.async {
            self.flushIfNeeded()
        }
    }
    
    // 시작시 상태 복구
    private func restoreEvents() {
        do {
            self.events = try store.load()
            self.sequence = events.map(\.sequence).max() ?? 0
            print("[LOG] Restored \(events.count) events")
        } catch {
            print("[FAIL] Failed to restore events: \(error)")
        }
    }
    
    private func persist() {
        do {
            try store.save(events)
        } catch {
            print("[FAIL] Failed to persist events: \(error)")
        }
    }
    
    private func flushIfNeeded() {
        guard !isFlushing else { return }
        guard !events.isEmpty else { return }
        
        isFlushing = true
    }
}
