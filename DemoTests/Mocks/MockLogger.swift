// Copyright © 2024 Evan Su. All rights reserved.

@testable import Demo
import Foundation

final class MockLogger: LoggerProtocol {
    var loggedMessages: [String] = []

    required init(subsystem: String = "", category: Demo.LoggingCategory = .network) {}

    func log(level: Demo.LogLevel, message: String) {
        logMessage(message)
    }

    func logSensetiveMessage(insensitive: String, sensitive: String) {
        logMessage(insensitive)
    }

    func info(_ message: String) {
        logMessage(message)
    }

    func fault(_ message: String) {
        logMessage(message)
    }

    func debug(_ message: String) {
        logMessage(message)
    }

    func error(_ message: String) {
        logMessage(message)
    }

    private func logMessage(_ message: String) {
        loggedMessages.append("\(message)")
    }
}
