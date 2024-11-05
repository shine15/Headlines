// Copyright © 2024 Evan Su. All rights reserved.

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        indices ~= index ? self[index] : nil
    }
}
