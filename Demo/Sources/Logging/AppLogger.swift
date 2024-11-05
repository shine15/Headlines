// Copyright © 2024 Evan Su. All rights reserved.

import Foundation
import OSLog

extension LogLevel {
    var osLogType: OSLogType {
        switch self {
        case .debug: .debug
        case .info: .info
        case .error: .error
        case .fault: .fault
        case .default: .default
        }
    }
}

final class AppLogger: LoggerProtocol {
    private let logger: Logger

    init(
        subsystem: String = Bundle.main.bundleIdentifier ?? "",
        category: LoggingCategory
    ) {
        logger = Logger(subsystem: subsystem, category: category.rawValue)
    }

    func log(
        level: LogLevel = .default,
        message: String
    ) {
        logger.log(
            level: level.osLogType,
            "\(message)"
        )
    }

    func logSensetiveMessage(insensitive: String, sensitive: String) {
        logger.log("\(insensitive): \(sensitive, privacy: .private)")
    }

    func debug(
        _ message: String
    ) {
        log(level: .debug, message: message)
    }

    func info(
        _ message: String
    ) {
        log(level: .info, message: message)
    }

    func error(
        _ message: String
    ) {
        log(level: .error, message: message)
    }

    func fault(
        _ message: String
    ) {
        log(level: .fault, message: message)
    }
}

extension AppLogger {
    static let network = AppLogger(category: .network)
}
