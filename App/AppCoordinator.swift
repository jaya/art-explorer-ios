//
//  AppCoordinator.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 15/06/25.
//

import SwiftUI
import Resolver

final class AppCoordinator {
    func makeArtListView() -> some View {
        let viewModel: ArtListViewModel = Resolver.resolve()
        return ArtListView(
            viewModel: viewModel,
            makeDetail: { art in
                self.makeArtDetailView(for: art)
            }
        )
    }
    
    func makeArtDetailView(for art: ArtObject) -> ArtDetailView {
        let factory: (ArtObject) -> ArtDetailViewModel = Resolver.resolve()
        let viewModel = factory(art)
        return ArtDetailView(viewModel: viewModel)
    }
}

