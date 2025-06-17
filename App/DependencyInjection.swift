//
//  DependencyInjection.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 15/06/25.
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { ArtService() as ArtServiceProtocol }
        register { FavoritesService() as FavoritesServiceProtocol }
        register { ArtListViewModel(service: resolve(), favoritesService: resolve()) }

        register { (resolver: Resolver) -> (ArtObject) -> ArtDetailViewModel in
            return { art in
                ArtDetailViewModel(art: art, service: resolver.resolve())
            }
        }
    }
}
