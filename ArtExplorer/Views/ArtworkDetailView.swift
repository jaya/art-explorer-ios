//
//  ArtworkDetailView.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

import SwiftUI
import Kingfisher

struct ArtworkDetailView: View {
    let artwork: Artwork
    @State private var isFavorite: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                KFImage(URL(string: artwork.primaryImage))
                    .placeholder {
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 250)
                                .cornerRadius(12)
                            ProgressView()
                        }
                    }
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)

                HStack {
                    Text(artwork.title)
                        .font(.title)
                        .bold()
                    Spacer()
                    Button(action: {
                        isFavorite.toggle()
                        // You can call a persist function here later
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite ? .red : .gray)
                            .imageScale(.large)
                            .padding(8)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                    }
                    .accessibilityLabel(isFavorite ? "Unfavorite" : "Favorite")
                }

                Text("Artist: \(artwork.artistDisplayName)")
                    .font(.subheadline)

                Text("Date: \(artwork.objectDate)")
                    .font(.subheadline)

                if !artwork.medium.isEmpty {
                    Text("Medium: \(artwork.medium)")
                        .font(.body)
                }

                if !artwork.creditLine.isEmpty {
                    Text("Credit: \(artwork.creditLine)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .navigationTitle("Artwork")
        .navigationBarTitleDisplayMode(.inline)
    }
}

