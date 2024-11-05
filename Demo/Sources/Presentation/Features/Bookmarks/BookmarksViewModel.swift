// Copyright © 2024 Evan Su. All rights reserved.

import Foundation

@MainActor
final class BookmarksViewModel: ObservableObject {
    private let localStorage: LocalStorageProtocol

    init(localStorage: LocalStorageProtocol) {
        self.localStorage = localStorage
    }

    let bookmarksTabTitle = "Bookmarks"
    let bookmarksTabIcon = "bookmark.circle.fill"
    let navigationTitle = "Bookmarks"

    @Published private(set) var bookmarks: [Article] = []

    func fetchAllBookmarks() {
        bookmarks = localStorage.fetchAllBookmarks()
    }

    func removeBookmark(indexSet: IndexSet) {
        guard let index = indexSet.first,
              let url = bookmarks[safe: index]?.url else { return }
        localStorage.removeBookmark(url: url)
        fetchAllBookmarks()
    }
}
