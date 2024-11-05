// Copyright © 2024 Evan Su. All rights reserved.

import SwiftUI

@MainActor
final class SourcesViewModel: ObservableObject {
    private let apiService: NewsAPIServiceProtocol
    private let sourcesManager: SourcesManagerProtocol
    @Published var selectedSourceID: String

    init(
        apiService: NewsAPIServiceProtocol,
        sourcesManager: SourcesManagerProtocol
    ) {
        self.apiService = apiService
        self.sourcesManager = sourcesManager
        selectedSourceID = sourcesManager.selectedSourceID
    }

    let sourcesTabTitle = "Sources"
    let sourcesTabIcon = "s.circle"
    let navigationTitle = "Select a news source"
    let errorMessage = "Something went wrong while fetching the sources. Please try again later."

    @Published private(set) var sources: [Source] = []
    @Published var showNetworkError = false
    @Published private(set) var showLoadingProgress = false

    func fetchAllSources() async {
        showNetworkError = false
        showLoadingProgress = true
        do {
            sources = try await apiService.fetchAllSources()
            showLoadingProgress = false
        } catch {
            showLoadingProgress = false
            showNetworkError = true
        }
    }

    func isSelected(source: Source) -> Bool {
        selectedSourceID == source.id
    }

    func updateSelectedSource(sourceID: String?) {
        guard let sourceID else { return }
        sourcesManager.setSelectedSourceID(sourceID)
        selectedSourceID = sourceID
    }
}
