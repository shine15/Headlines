// Copyright © 2024 Evan Su. All rights reserved.

import Foundation

protocol UserDefaultsProtocol {
    func string(forKey: String) -> String?
    func set(_ value: Any?, forKey defaultName: String)
}

extension UserDefaults: UserDefaultsProtocol {}
