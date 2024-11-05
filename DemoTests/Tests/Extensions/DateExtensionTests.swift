// Copyright © 2024 Evan Su. All rights reserved.

@testable import Demo
import XCTest

final class DateExtensionTests: XCTestCase {
    // Helper function to create a date from a specific time ago
    private func date(hoursAgo: Int) -> Date {
        Calendar.current.date(byAdding: .hour, value: -hoursAgo, to: Date())!
    }

    private func date(minutesAgo: Int) -> Date {
        Calendar.current.date(byAdding: .minute, value: -minutesAgo, to: Date())!
    }

    func test_dateExtension_timeAgo_hours() {
        let twoHoursAgo = date(hoursAgo: 2)
        XCTAssertEqual(
            twoHoursAgo.timeAgo,
            "2 hours ago",
            "The 'timeAgo' method should return the correct result for 2 hours ago."
        )

        let fiveHoursAgo = date(hoursAgo: 5)
        XCTAssertEqual(
            fiveHoursAgo.timeAgo,
            "5 hours ago",
            "The 'timeAgo' method should return the correct result for 5 hours ago."
        )

        let oneHourAgo = date(hoursAgo: 1)
        XCTAssertEqual(
            oneHourAgo.timeAgo,
            "1 hour ago",
            "The 'timeAgo' method should return the correct result for 1 hour ago."
        )
    }

    func test_dateExtension_timeAgo_minutes() {
        let thirtyMinutesAgo = date(minutesAgo: 30)
        XCTAssertEqual(
            thirtyMinutesAgo.timeAgo,
            "30 minutes ago",
            "The 'timeAgo' method should return the correct result for 30 minutes ago."
        )

        let tenMinutesAgo = date(minutesAgo: 10)
        XCTAssertEqual(
            tenMinutesAgo.timeAgo,
            "10 minutes ago",
            "The 'timeAgo' method should return the correct result for 10 minutes ago."
        )

        let oneMinuteAgo = date(minutesAgo: 1)
        XCTAssertEqual(
            oneMinuteAgo.timeAgo,
            "1 minute ago",
            "The 'timeAgo' method should return the correct result for 1 minute ago."
        )
    }

    func test_dateExtension_timeAgo_justNow() {
        let justNow = Date() // This is the current time, no difference.
        XCTAssertEqual(
            justNow.timeAgo,
            "Just now",
            "The 'timeAgo' method should return 'Just now' when the date is the current date."
        )
    }

    func test_dateExtension_timeAgo_for_seconds() {
        // Create a date 5 seconds ago.
        let fiveSecondsAgo = Calendar.current.date(byAdding: .second, value: -5, to: Date())!
        XCTAssertEqual(
            fiveSecondsAgo.timeAgo,
            "Just now",
            "The 'timeAgo' method should return 'Just now' for times close to the current moment."
        )
    }

    // Test if timeAgo works in boundary cases
    func test_dateExtension_timeAgo_for_edgeCases() {
        // Date 59 minutes ago should still return the minute-based string
        let fiftyNineMinutesAgo = date(minutesAgo: 59)
        XCTAssertEqual(
            fiftyNineMinutesAgo.timeAgo,
            "59 minutes ago",
            "The 'timeAgo' method should return '59 minutes ago' for a time 59 minutes ago."
        )

        // Date 61 minutes ago should switch to hours
        let sixtyOneMinutesAgo = date(minutesAgo: 61)
        XCTAssertEqual(
            sixtyOneMinutesAgo.timeAgo,
            "1 hour ago",
            "The 'timeAgo' method should return '1 hour ago' for a time 61 minutes ago."
        )
    }
}
