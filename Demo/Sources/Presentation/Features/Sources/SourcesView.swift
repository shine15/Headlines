// Copyright © 2024 Evan Su. All rights reserved.

import SwiftUI

struct SourcesView: View {
    @StateObject private var viewModel: SourcesViewModel

    init(viewModel: SourcesViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            sourcesList(sources: viewModel.sources)
                .navigationTitle(viewModel.navigationTitle)
        }
        .tabItem { Label(viewModel.sourcesTabTitle, systemImage: viewModel.sourcesTabIcon) }
        .task {
            await viewModel.fetchAllSources()
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

extension SourcesView {
    private func row(source: Source) -> some View {
        HStack {
            Text(source.name ?? "")
            Spacer()

            if viewModel.isSelected(source: source) {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
    }

    private func sourcesList(sources: [Source]) -> some View {
        List(sources) { source in
            row(source: source)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.updateSelectedSource(sourceID: source.id)
                }
        }
        .listStyle(PlainListStyle())
    }
}
