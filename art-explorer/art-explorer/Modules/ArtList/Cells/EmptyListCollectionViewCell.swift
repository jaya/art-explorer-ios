//
//  EmptyListCell.swift
//  art-explorer
//
//  Created by Pedro Freddi on 21/06/25.
//

import UIKit
import Foundation

class EmptyListCollectionViewCell: UICollectionViewCell {

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

    var message: UILabel = {
        let label = UILabel()
        label.text = "No artworks found"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cardView)
        cardView.addSubview(message)

        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            message.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            message.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            message.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            message.centerXAnchor.constraint(equalTo: cardView.centerXAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
