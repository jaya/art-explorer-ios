//
//  ArtItemCollectionViewCell.swift
//  art-explorer
//
//  Created by Pedro Freddi on 21/06/25.
//

import UIKit
import Foundation

class ArtItemCollectionViewCell: UICollectionViewCell {

    var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? .secondarySystemBackground
                : .white
        }
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.label.withAlphaComponent(0.2).cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var preview: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        imageView.backgroundColor = .secondarySystemBackground
        imageView.kf.indicatorType = .activity
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func setupCell(_ artObject: ArtObject) {
        nameLabel.text = artObject.title
        if let url = URL(string: artObject.primaryImageSmall) {
            preview.kf.setImage(with: url)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cardView)
        cardView.addSubview(preview)
        cardView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            preview.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            preview.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            preview.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            preview.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: preview.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            nameLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        preview.kf.cancelDownloadTask()
        preview.image = nil
    }
}
