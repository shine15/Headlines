// Copyright © 2024 Evan Su. All rights reserved.

import SwiftUI

struct HeadlinesView: View {
    @StateObject private var viewModel: HeadlinesViewModel

    init(viewModel: HeadlinesViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                newsList
                if viewModel.showLoadingProgress {
                    progressView
                }
            }
            .navigationTitle(viewModel.navigationTitle)
        }
        .tabItem { Label(viewModel.headlinesTabTitle, systemImage: viewModel.headlinesTabIcon) }
        .task {
            await viewModel.fetchHeadlines()
        }
        .alert(isPresented: $viewModel.showNetworkError) {
            Alert(
                title: Text(""),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

// MARK: - Subviews

extension HeadlinesView {
    private var newsList: some View {
        List {
            ForEach(viewModel.headlines) { article in
                ZStack {
                    HeadlineRowView(viewModel: HeadlineRowViewModel(article: article))
                    NavigationLink(destination: destination(article: article)) {
                        EmptyView()
                    }.opacity(0)
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            }
        }
        .listRowSpacing(10)
    }

    private var progressView: some View {
        ProgressView()
    }

    private func destination(article: Article) -> some View {
        NewsDetailView(viewModel: NewsDetailViewModel(
            article: article,
            localStorage: LocalStorageManager.shared
        ))
    }
}
