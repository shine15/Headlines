// Copyright © 2024 Evan Su. All rights reserved.

import Kingfisher
import SwiftUI

struct HeadlineRowView: View {
    private let viewModel: HeadlineRowViewModel

    @State private var imageLoaded = false

    init(viewModel: HeadlineRowViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                titleView
                imageView
            }
            descriptionView
            authorView
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
    }
}

// MARK: - Subviews

extension HeadlineRowView {
    private var titleView: some View {
        Text(viewModel.title)
            .font(.headline)
    }

    @MainActor
    @ViewBuilder
    private var imageView: some View {
        if let imageURL = viewModel.imageURL {
            ZStack {
                KFImage(
                    URL(string: imageURL)
                )
                .onSuccess { _ in
                    imageLoaded = true
                }
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                .clipped()
                .cornerRadius(10)
                if !imageLoaded {
                    ProgressView()
                }
            }
        }
    }

    private var descriptionView: some View {
        Text(viewModel.description)
            .font(.body)
    }

    private var authorView: some View {
        Text(viewModel.author)
            .font(.footnote)
            .foregroundColor(.gray)
    }
}
