// Copyright © 2024 Evan Su. All rights reserved.

@testable import Demo
import Foundation

final class MockUserDefaults: UserDefaultsProtocol {
    private var storage: [String: Any] = [:]

    func string(forKey key: String) -> String? {
        storage[key] as? String
    }

    func set(_ value: Any?, forKey key: String) {
        storage[key] = value
    }
}
