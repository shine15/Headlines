// Copyright © 2024 Evan Su. All rights reserved.

@testable import Demo
import Foundation

final class MockLocalStorage: LocalStorageProtocol {
    // A simple in-memory storage to hold the bookmarks
    private var storage: [String: Article] = [:]

    func saveBookmark(article: Article) {
        guard let url = article.url else { return }
        storage[url] = article
    }

    func fetchAllBookmarks() -> [Article] {
        Array(storage.values)
    }

    func removeBookmark(url: String) {
        storage.removeValue(forKey: url)
    }

    var allBookmarksURL: [String] {
        Array(storage.keys)
    }
}
