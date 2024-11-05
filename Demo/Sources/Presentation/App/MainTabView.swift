// Copyright © 2024 Evan Su. All rights reserved.

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            headlinesView
            sourcesView
            bookmarksView
        }
    }
}

extension MainTabView {
    @MainActor
    private var headlinesView: some View {
        let viewModel = HeadlinesViewModel(
            apiService: NewsAPIService(),
            sourcesManager: SourcesManager.shared
        )
        return HeadlinesView(viewModel: viewModel)
    }

    @MainActor
    private var sourcesView: some View {
        let viewModel = SourcesViewModel(
            apiService: NewsAPIService(),
            sourcesManager: SourcesManager.shared
        )
        return SourcesView(viewModel: viewModel)
    }

    @MainActor
    private var bookmarksView: some View {
        let viewModel = BookmarksViewModel(localStorage: LocalStorageManager.shared)
        return BookmarksView(viewModel: viewModel)
    }
}
