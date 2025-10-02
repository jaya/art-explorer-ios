//
//  ArtDetailViewController.swift
//  art-explorer
//
//  Created by Pedro Freddi on 19/06/25.
//

import Foundation
import UIKit
import Kingfisher

class ArtDetailViewController: BaseViewController {

    var viewModel: ArtDetailViewModel!

    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()

    var favoriteButton = UIBarButtonItem()

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    init(viewModel: ArtDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        navigationItem.rightBarButtonItem = favoriteButton
    }

    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupFavoriteButton()
        setupUI()
        setupCancelables()
    }

    internal override func setupCancelables() {
        viewModel.$isFavorite
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isFavorite in
                self?.changeFavoriteButtonImage(isFavorite)
            }
            .store(in: &cancellables)
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])

        if let art = viewModel.artObject {
            if let imageURL = URL(string: art.primaryImageSmall), !art.primaryImageSmall.isEmpty {
                imageView.kf.setImage(with: imageURL)
                imageView.kf.indicatorType = .activity
                imageView.backgroundColor = .clear
            }
            stackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(makeLabel(title: "Title", value: art.title))
            stackView.addArrangedSubview(makeLabel(title: "Artist", value: art.artistDisplayName))
            stackView.addArrangedSubview(makeLabel(title: "Date", value: art.objectDate))
            stackView.addArrangedSubview(makeLabel(title: "Medium", value: art.medium))
            stackView.addArrangedSubview(makeLabel(title: "Department", value: art.department))
        }
    }

    private func setupFavoriteButton() {
        favoriteButton.primaryAction = UIAction { [weak self] _ in
            self?.viewModel.didTapFavoriteButton()
        }
    }

    private func makeLabel(title: String, value: String?) -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 4

        let titleLabel = UILabel()
        titleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        titleLabel.textColor = .secondaryLabel
        titleLabel.text = title

        let valueLabel = UILabel()
        valueLabel.font = UIFont.preferredFont(forTextStyle: .body)
        valueLabel.textColor = .label
        valueLabel.numberOfLines = 0
        valueLabel.text = value?.isEmpty == false ? value : "—"

        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(valueLabel)

        return container
    }

    private func changeFavoriteButtonImage(_ isFavorite: Bool) {
        favoriteButton.image = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
    }
}
