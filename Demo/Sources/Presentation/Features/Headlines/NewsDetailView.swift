// Copyright © 2024 Evan Su. All rights reserved.

import SwiftUI

struct NewsDetailView: View {
    @StateObject private var viewModel: NewsDetailViewModel

    init(viewModel: NewsDetailViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        webView
            .navigationBarItems(trailing: saveButton)
            .onAppear(perform: {
                viewModel.checkSaved()
            })
    }
}

extension NewsDetailView {
    private var webView: some View {
        WebView(url: viewModel.url)
            .navigationBarTitleDisplayMode(.inline)
    }

    private var saveButton: some View {
        Button(action: {
            viewModel.toggleSaved()
        }) {
            Image(systemName: viewModel.isSaved ? "bookmark.fill" : "bookmark")
        }
    }
}
