// Copyright © 2024 Evan Su. All rights reserved.

@testable import Demo
import XCTest

final class SourcesManagerTests: XCTestCase {
    private var mockUserDefaults: MockUserDefaults!
    private var sourcesManager: SourcesManager!

    override func setUp() {
        super.setUp()

        // Initialize mock UserDefaults
        mockUserDefaults = MockUserDefaults()

        // Inject mock UserDefaults into SourcesManager
        sourcesManager = SourcesManager(userDefaults: mockUserDefaults)
    }

    override func tearDown() {
        mockUserDefaults = nil
        sourcesManager = nil
        super.tearDown()
    }

    // Check initial selected source ID when no value is saved
    func test_sourceManager_initialSelectedSourceID() {
        // Given
        mockUserDefaults.set(nil, forKey: UserDefaultsKey.selectedSource.rawValue)

        // Then
        XCTAssertEqual(
            sourcesManager.selectedSourceID,
            "abc-news-au",
            "The initial source ID should be the default value."
        )
    }

    // Check if setting a new selected source ID works correctly
    func test_sourceManager_setSelectedSourceID() {
        // Given
        let newSourceID = "bbc-news"

        // When
        sourcesManager.setSelectedSourceID(newSourceID)

        // Then
        XCTAssertEqual(
            mockUserDefaults.string(forKey: UserDefaultsKey.selectedSource.rawValue),
            newSourceID,
            "The source ID should be saved correctly in UserDefaults."
        )
    }

    // Ensure that the correct source ID is returned after setting it
    func test_sourceManager_getSelectedSourceID_afterSetting() {
        // Given
        let newSourceID = "cnn"
        sourcesManager.setSelectedSourceID(newSourceID)

        // When
        let selectedSourceID = sourcesManager.selectedSourceID

        // Then
        XCTAssertEqual(
            selectedSourceID,
            newSourceID,
            "The selected source ID should match the value set earlier."
        )
    }

    // Check default source ID when no source ID is saved
    func test_sourceManager_defaultSourceID_whenNoSourceIDIsSaved() {
        // Given
        mockUserDefaults.set(nil, forKey: UserDefaultsKey.selectedSource.rawValue)

        // When
        let selectedSourceID = sourcesManager.selectedSourceID

        // Then
        XCTAssertEqual(
            selectedSourceID,
            "abc-news-au",
            "The source ID should fall back to the default value when no value is saved."
        )
    }

    // Ensure that the last source ID is returned after multiple updates
    func test_sourceManager_setSourceID_multipleTimes() {
        // Given
        sourcesManager.setSelectedSourceID("source-1")
        sourcesManager.setSelectedSourceID("source-2")

        // When
        let selectedSourceID = sourcesManager.selectedSourceID

        // Then
        XCTAssertEqual(
            selectedSourceID,
            "source-2",
            "The source ID should be updated correctly after multiple set operations."
        )
    }
}
