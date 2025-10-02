//
//  FavoritesListViewModel.swift
//  art-explorer
//
//  Created by Pedro Freddi on 21/06/25.
//

import UIKit
import Combine

protocol FavoritesListViewModelProtocol: AnyObject {
    //    var repository: ArtRepository { get }
    //    var isLoading: Bool { get }
    //    var artObjects: [ArtObject] { get set }
    //    var cancelables: Set<AnyCancellable> { get set }

    func openArtDetail(_ index: Int)
}

class FavoritesListViewModel: FavoritesListViewModelProtocol {
    private(set) var navigationController: UINavigationController?
    @Published private(set) var artObjects: [ArtObject] = []
    private(set) var cancelables: Set<AnyCancellable> = []
    private var repository: ArtRepository

    init(repository: ArtRepository, navigationController: UINavigationController) {
        self.repository = repository
        self.navigationController = navigationController
        artObjects = repository.favorites
        setupCancelables()
    }

    func setupCancelables() {
        repository.$favorites
            .receive(on: DispatchQueue.main)
            .assign(to: \.artObjects ,on: self)
            .store(in: &cancelables)
    }

    func getFavorites() {
        Task {
            await repository.getFavorites()
        }
    }

    func openArtDetail(_ index: Int) {
        let viewModel = ArtDetailViewModel(artId: artObjects[index].objectID,
                                           navigationController: navigationController,
                                           repository: repository)
            let viewController = ArtDetailViewController(viewModel: viewModel)
            navigationController?.pushViewController(viewController, animated: true)
    }
}
