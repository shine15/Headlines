// Copyright © 2024 Evan Su. All rights reserved.

import SwiftUI

@main
struct DemoApp: App {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.brand)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.brand)]
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .accentColor(.brand)
        }
    }
}
