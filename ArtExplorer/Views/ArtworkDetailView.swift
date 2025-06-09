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
    @StateObject var viewModel: ArtworkDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                KFImage(URL(string: viewModel.artwork.primaryImageSmall))
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
                    Text(viewModel.artwork.title)
                        .font(.title)
                        .bold()

                    Spacer()

                    Button(action: {
                        viewModel.toggleFavorite()
                    }) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .imageScale(.large)
                            .padding(8)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                    }
                }

                Text("Artist: \(viewModel.artwork.artistDisplayName)")
                    .font(.subheadline)

                Text("Date: \(viewModel.artwork.objectDate)")
                    .font(.subheadline)

                if !viewModel.artwork.medium.isEmpty {
                    Text("Medium: \(viewModel.artwork.medium)")
                        .font(.body)
                }

                if !viewModel.artwork.creditLine.isEmpty {
                    Text("Credit: \(viewModel.artwork.creditLine)")
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
