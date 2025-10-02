//
//  FavoritesListViewController.swift
//  art-explorer
//
//  Created by Pedro Freddi on 21/06/25.
//

import Foundation
import UIKit
import Kingfisher

class FavoritesListViewController: BaseViewController {

    var viewModel: FavoritesListViewModel!

    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ArtItemCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        return collectionView
    }()

    init(viewModel: FavoritesListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 1)
    }

    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFavorites()
    }

    internal override func setupCancelables() {
        viewModel.$artObjects
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }

    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension FavoritesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.artObjects.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ArtItemCollectionViewCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
        }
        cell.setupCell(self.viewModel.artObjects[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.openArtDetail(indexPath.row)
    }
}

extension FavoritesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 250)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
