//
//  FileEventStore.swift
//  EventTrackerSDK
//
//  Created by 손지영 on 3/30/26.
//

import Foundation

final class FileEventStore: EventStore {
    private let fileURL: URL
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    init(fileURL: URL) {
        self.fileURL = fileURL
        encoder.outputFormatting = [.prettyPrinted]
    }
    
    func load() throws -> [TrackedEvent] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return []
        }
        
        let data = try Data(contentsOf: fileURL)
        return try decoder.decode([TrackedEvent].self, from: data)
    }
    
    func save(_ events: [TrackedEvent]) throws {
        let data = try encoder.encode(events)
        try data.write(to: fileURL, options: .atomic)
    }
}
