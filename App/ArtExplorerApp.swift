//
//  ArtExplorerApp.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 15/06/25.
//

import SwiftUI

@main
struct ArtExplorerApp: App {
    let coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            coordinator.makeArtListView()
        }
    }
}
