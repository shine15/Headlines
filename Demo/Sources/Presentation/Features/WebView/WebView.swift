// Copyright © 2024 Evan Su. All rights reserved.

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL?

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url else { return }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
