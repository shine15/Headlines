// Copyright © 2024 Evan Su. All rights reserved.

import Foundation

extension Date {
    var timeAgo: String {
        let calendar = Calendar.current
        let now = Date()

        let components = calendar.dateComponents([.hour, .minute, .second], from: self, to: now)

        if let hours = components.hour, hours > 0 {
            return "\(hours) hour\(hours > 1 ? "s" : "") ago"
        } else if let minutes = components.minute, minutes > 0 {
            return "\(minutes) minute\(minutes > 1 ? "s" : "") ago"
        } else {
            return "Just now"
        }
    }
}
