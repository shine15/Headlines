// Copyright © 2024 Evan Su. All rights reserved.

import Foundation

protocol SourcesManagerProtocol {
    var selectedSourceID: String { get }
    func setSelectedSourceID(_ id: String)
}

enum UserDefaultsKey: String {
    case selectedSource
}

final class SourcesManager: SourcesManagerProtocol {
    static let shared = SourcesManager(userDefaults: UserDefaults.standard)

    private let userDefaults: UserDefaultsProtocol

    init(userDefaults: UserDefaultsProtocol) {
        self.userDefaults = userDefaults
    }

    var selectedSourceID: String {
        userDefaults.string(forKey: UserDefaultsKey.selectedSource.rawValue) ?? "abc-news-au"
    }

    func setSelectedSourceID(_ id: String) {
        userDefaults.set(id, forKey: UserDefaultsKey.selectedSource.rawValue)
    }
}
