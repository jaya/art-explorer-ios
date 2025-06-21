//
//  Logger.swift
//  art-explorer
//
//  Created by Pedro Freddi on 16/06/25.
//

import OSLog

extension Logger {
    private static var subsystem: String {
        Bundle.main.bundleIdentifier ?? "art-explorer"
    }

    static let network = Logger(
        subsystem: subsystem,
        category: "network"
    )

    static let viewCycle = Logger(
        subsystem: subsystem,
        category: "view-cycle"
    )

    static let statistics = Logger(
        subsystem: subsystem,
        category: "statistics"
    )

    static let database = Logger(
        subsystem: subsystem,
        category: "database"
    )
}
