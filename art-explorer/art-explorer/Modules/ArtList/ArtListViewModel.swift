//
//  ArtListViewModel.swift
//  art-explorer
//
//  Created by Pedro Freddi on 18/06/25.
//

import UIKit
import Combine

protocol ArtListViewModelDelegate: AnyObject {
    var repository: ArtRepository { get }
    var isLoading: Bool { get }
    var artObjects: [ArtObject] { get set }
    var cancelables: Set<AnyCancellable> { get set }

    func getNextPage()
    func openArtDetail(for artId: Int)
}

class ArtListViewModel: ArtListViewModelDelegate, NavigableViewModel {
    var isLoading: Bool = false
    var navigationController: UINavigationController?
    @Published var artObjects: [ArtObject] = []
    var cancelables: Set<AnyCancellable> = []
    var repository: ArtRepository

    init(repository: ArtRepository, navigationController: UINavigationController) {
        self.repository = repository
        self.navigationController = navigationController
        setupCancelables()
    }

    func setupCancelables() {
        repository.$artObjects
            .receive(on: DispatchQueue.main)
            .assign(to: \.artObjects ,on: self)
            .store(in: &cancelables)
    }

    func getNextPage() {
        Task {
            await getNextPage()
        }
    }

    func getNextPage() async {
        if !isLoading {
            isLoading = true
            await repository.fetchArtObjects()
            isLoading = false
        }
    }

    func openArtDetail(for artId: Int) {
        let viewModel = ArtDetailViewModel(artId: repository.artObjects[artId].objectID,
                                           navigationController: navigationController,
                                           repository: repository)
            let viewController = ArtDetailViewController(viewModel: viewModel)
            navigationController?.pushViewController(viewController, animated: true)
    }
}
