//
//  ArtListViewController.swift
//  art-explorer
//
//  Created by Pedro Freddi on 18/06/25.
//

import Foundation
import UIKit
import Kingfisher
import Combine

class ArtListViewController: BaseViewController {

    var viewModel: ArtListViewModel!

    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ArtItemCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(EmptyListCollectionViewCell.self, forCellWithReuseIdentifier: "emptyCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        return collectionView
    }()

    var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    let searchController = UISearchController(searchResultsController: nil)

    init(viewModel: ArtListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        tabBarItem = UITabBarItem(title: "Art", image: UIImage(systemName: "photo.artframe"), tag: 0)
    }

    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.getNextPage()
        title = "Art Explorer"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    internal override func setupCancelables() {
        self.viewModel.$artObjects
            .receive(on: DispatchQueue.main)
            .sink { [weak self] objects in
                print("OBJ: ", objects)
                self?.collectionView.reloadData()
            }.store(in: &cancellables)

        self.viewModel.$isFirstLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isFirstLoading in
                self?.toggleFirstLoading(isFirstLoading)
            }
            .store(in: &cancellables)

        self.viewModel.$error
            .compactMap { $0 }
            .sink { [weak self] error in
                self?.showAlert(title: "Error", message: error.localizedDescription)
                self?.viewModel.clearError()
            }
            .store(in: &cancellables)
    }

    private func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        collectionView.dataSource = self
        collectionView.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func toggleFirstLoading(_ isFirstLoading: Bool) {
        if isFirstLoading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
        self.searchController.searchBar.isHidden = isFirstLoading
        self.activityIndicator.isHidden = !isFirstLoading
        self.collectionView.isHidden = isFirstLoading
    }
}

extension ArtListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.artObjects.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item: ArtListItem = self.viewModel.artObjects[indexPath.row]
        switch item {
        case .artObject(let artObject):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ArtItemCollectionViewCell
            cell.setupCell(artObject)
            return cell
        case .empty:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.openArtDetail(indexPath.row)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height * 1.5 {
            viewModel.getNextPage()
        }
    }
}

extension ArtListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let item: ArtListItem = self.viewModel.artObjects[indexPath.row]
        switch item {
        case .artObject:
            return CGSize(width: collectionView.bounds.width, height: 250)
        case .empty:
            return CGSize(width: collectionView.bounds.width, height: 50)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension ArtListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        viewModel.updateSearchResults(query)
    }
}
