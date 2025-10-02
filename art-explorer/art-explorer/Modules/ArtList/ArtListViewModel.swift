//
//  ArtListViewModel.swift
//  art-explorer
//
//  Created by Pedro Freddi on 18/06/25.
//

import UIKit
import Combine
import OSLog

protocol ArtListViewModelProtocol: AnyObject {
    var isLoading: Bool { get }
    var artObjects: [ArtListItem] { get }
    var isFirstLoading: Bool { get }
    var error: ArtObjectRepositoryError? { get }
    var navigationController: UINavigationController? { get }
    func getNextPage()
    func openArtDetail(_ index: Int)
    func updateSearchResults(_ query: String)
    func clearError()
}

enum ArtListItem {
    case empty, artObject(ArtObject)
}

class ArtListViewModel: ArtListViewModelProtocol {
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var artObjects: [ArtListItem] = []
    @Published private(set) var isFirstLoading: Bool = true
    @Published private(set) var error: ArtObjectRepositoryError?
    private(set) var navigationController: UINavigationController?
    private(set) var repository: ArtRepository
    private(set) var cancelables: Set<AnyCancellable> = []

    init(repository: ArtRepository, navigationController: UINavigationController) {
        self.repository = repository
        self.navigationController = navigationController
        setupCancelables()
    }

    private func setupCancelables() {
        repository.$artObjects
            .receive(on: DispatchQueue.main)
            .map {
                $0.map { ArtListItem.artObject($0) }
            }
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
            do {
                try await repository.fetchArtObjects()
            } catch let error as ArtObjectRepositoryError {
                self.error = error
            } catch {
                Logger.network.error("Failed to fetch art objects: \(error)")
            }
            isLoading = false
            isFirstLoading = false
        }
    }

    func updateSearchResults(_ query: String) {
        guard !query.isEmpty else {
            artObjects = repository.artObjects.map { ArtListItem.artObject($0) }
            return
        }

        let filteredObjects = repository.artObjects
            .filter {
                $0.title.localizedCaseInsensitiveContains(query) ||
                $0.medium.localizedCaseInsensitiveContains(query) ||
                $0.artistDisplayName.localizedCaseInsensitiveContains(query) ||
                $0.department.localizedCaseInsensitiveContains(query)
            }
            .map { ArtListItem.artObject($0) }

        artObjects = filteredObjects.isEmpty ? [.empty] : filteredObjects
    }

    func openArtDetail(_ index: Int) {
        guard case let .artObject(artObject) = artObjects[index] else { return }
        let viewModel = ArtDetailViewModel(artId: artObject.objectID,
                                           navigationController: navigationController,
                                           repository: repository)
        let viewController = ArtDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func clearError() {
        error = nil
    }
}
