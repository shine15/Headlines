// Copyright © 2024 Evan Su. All rights reserved.

import SwiftUI

struct BookmarksView: View {
    @StateObject private var viewModel: BookmarksViewModel

    init(viewModel: BookmarksViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            bookmarkList
                .navigationTitle(viewModel.navigationTitle)
        }
        .tabItem { Label(viewModel.bookmarksTabTitle, systemImage: viewModel.bookmarksTabIcon) }
        .onAppear(perform: {
            viewModel.fetchAllBookmarks()
        })
    }
}

// MARK: - Subviews

extension BookmarksView {
    private var bookmarkList: some View {
        List {
            ForEach(viewModel.bookmarks) { article in
                ZStack {
                    HeadlineRowView(viewModel: HeadlineRowViewModel(article: article))
                    NavigationLink(destination: destination(article: article)) {
                        EmptyView()
                    }.opacity(0)
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            }
            .onDelete(perform: removeRows)
        }
        .listRowSpacing(10)
    }

    private func destination(article: Article) -> some View {
        NewsDetailView(viewModel: NewsDetailViewModel(
            article: article,
            localStorage: LocalStorageManager.shared
        ))
    }

    func removeRows(at offsets: IndexSet) {
        viewModel.removeBookmark(indexSet: offsets)
    }
}
