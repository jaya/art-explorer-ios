//
//  ArtworkView.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

import SwiftUI
import Kingfisher

struct ArtworkView: View {
    let artwork: Artwork

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            KFImage(URL(string: artwork.primaryImageSmall))
                .placeholder {
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 250)
                            .cornerRadius(12)
                        ProgressView()
                    }
                }
                .cancelOnDisappear(true)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: UIScreen.main.bounds.width - 32,
                       minHeight: 250,
                       maxHeight: 250)
                .clipped()
                .cornerRadius(12)
                .shadow(radius: 4)

            VStack(alignment: .leading) {
                Text(artwork.title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(artwork.artistDisplayName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(artwork.objectDate)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 12)
        }
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 4)
        .padding(.horizontal)
        .padding(.top, 8)
    }
}
