// Copyright © 2024 Evan Su. All rights reserved.

import SwiftUI

@MainActor
final class HeadlinesViewModel: ObservableObject {
    private let apiService: NewsAPIServiceProtocol
    private let sourcesManager: SourcesManagerProtocol

    init(
        apiService: NewsAPIServiceProtocol,
        sourcesManager: SourcesManagerProtocol
    ) {
        self.apiService = apiService
        self.sourcesManager = sourcesManager
    }

    let headlinesTabTitle = "News"
    let headlinesTabIcon = "newspaper"
    let navigationTitle = "Top Stories"
    let errorMessage = "Something went wrong while fetching the latest news. Please try again later."

    @Published private(set) var headlines: [Article] = []
    @Published var showNetworkError = false
    @Published private(set) var showLoadingProgress = true

    func fetchHeadlines() async {
        showNetworkError = false
        showLoadingProgress = true
        do {
            headlines = try await apiService.fetchHeadlines(source: sourcesManager.selectedSourceID)
            showLoadingProgress = false
        } catch {
            showLoadingProgress = false
            showNetworkError = true
        }
    }
}
