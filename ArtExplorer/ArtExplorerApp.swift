//
//  ArtExplorerApp.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

import SwiftUI
import SwiftData

@main
struct ArtExplorerApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: ArtworkModel.self)
    }
}
