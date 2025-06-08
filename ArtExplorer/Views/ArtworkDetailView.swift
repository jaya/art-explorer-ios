//
//  ArtworkDetailView.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

import SwiftUI
import SwiftData
import Kingfisher

struct ArtworkDetailView: View {
    var artwork: Artwork

    @Environment(\.modelContext) private var context

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

                    Button(action: toggleFavorite) {
//                        Image(systemName: artwork.isFavorite ? "heart.fill" : "heart")
//                            .foregroundColor(artwork.isFavorite ? .red : .gray)
                        Image(systemName:"heart.fill")
                            .foregroundColor(.red)
                            .imageScale(.large)
                            .padding(8)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                    }
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

    private func toggleFavorite() {
//        artwork.isFavorite.toggle()
//
//        if artwork.isFavorite {
//            context.insert(artwork)
//        } else {
//            context.delete(artwork)
//        }

        context.insert(artwork.toArtworkModel())

        do {
            try? context.save()
        } catch {
            print("Error on saving \(error)")
        }
    }
}
