// Copyright © 2024 Evan Su. All rights reserved.

@testable import Demo
import Foundation

final class MockSourcesManager: SourcesManagerProtocol {
    // Store the selected source ID in memory
    private var internalSelectedSourceID: String = ""

    var selectedSourceID: String {
        internalSelectedSourceID
    }

    func setSelectedSourceID(_ id: String) {
        internalSelectedSourceID = id
    }
}
