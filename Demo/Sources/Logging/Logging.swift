// Copyright © 2024 Evan Su. All rights reserved.

import Foundation

enum LogLevel {
    case debug
    case info
    case error
    case fault
    case `default`
}

enum LoggingCategory: String {
    case network
    case decoding
}

protocol LoggerProtocol {
    init(subsystem: String, category: LoggingCategory)
    func log(level: LogLevel, message: String)
    func logSensetiveMessage(insensitive: String, sensitive: String)
    func debug(_ message: String)
    func info(_ message: String)
    func error(_ message: String)
    func fault(_ message: String)
}
