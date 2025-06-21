//
//  ArtDetailViewModel.swift
//  art-explorer
//
//  Created by Pedro Freddi on 19/06/25.
//

import UIKit
import OSLog
import Combine

protocol NavigableViewModel {
    var navigationController: UINavigationController? { get }
}

protocol ArtDetailViewModelDelegate: AnyObject {
    var artId: Int { get }
    var isFavorite: Bool { get }
    var repository: ArtRepository { get }
    func didTapFavoriteButton()
}

class ArtDetailViewModel: ArtDetailViewModelDelegate, NavigableViewModel {
    var navigationController: UINavigationController?
    var artId: Int
    var repository: ArtRepository
    @Published var artObject: ArtObject?
    @Published var isFavorite: Bool
    var cancelables: Set<AnyCancellable> = []

    init(artId: Int, navigationController: UINavigationController?, repository: ArtRepository) {
        self.artId = artId
        self.navigationController = navigationController
        self.repository = repository
        isFavorite = repository.isArtFavorite(artId)
        artObject = repository.getArtById(artId)
        setupCancelables()
    }

    deinit {
        #if DEBUG
        Logger.viewCycle.info("\(type(of: self)) deallocated")
        #endif
    }

    func setupCancelables() {
        repository.$artObjects
            .map { [weak self] in
                $0.filter { $0.objectID == self?.artId }
            }
            .compactMap { $0.first }
            .receive(on: DispatchQueue.main)
            .assign(to: \.artObject, on: self)
            .store(in: &cancelables)

        repository.$favoriteArts
            .map { [weak self] in
                guard let self else { return false }
                return $0.contains(self.artId)
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.isFavorite, on: self)
            .store(in: &cancelables)
    }

    func didTapFavoriteButton() {
        if isFavorite {
            repository.removeFavorite(artId: artId)
        } else {
            repository.addFavorite(artId: artId)
        }
    }
}
