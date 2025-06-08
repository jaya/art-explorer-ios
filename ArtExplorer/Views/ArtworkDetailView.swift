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

                Text(artwork.title)
                    .font(.title)
                    .bold()

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
