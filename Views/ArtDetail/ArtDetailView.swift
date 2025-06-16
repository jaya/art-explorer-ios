//
//  ArtDetailView.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 16/06/25.
//

import SwiftUI

public struct ArtDetailView: View {
    @ObservedObject var viewModel: ArtDetailViewModel
    
    public var body: some View {
        let art = viewModel.art
        
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: art.primaryImage)) { phase in
                    switch phase {
                    case .empty:
                        Color.gray.opacity(0.2)
                            .frame(height: 300)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 300)
                            .cornerRadius(12)
                    case .failure:
                        Color.gray.opacity(0.2)
                            .frame(height: 300)
                    @unknown default:
                        EmptyView()
                    }
                }
                .accessibilityIdentifier("detailImage")
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(art.title)
                        .font(.title2.bold())
                        .accessibilityIdentifier("detailTitle")
                    
                    if !art.artistDisplayName.isEmpty {
                        Text(art.artistDisplayName)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    if !art.artistDisplayBio.isEmpty {
                        Text(art.artistDisplayBio)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                
                HStack(spacing: 12) {
                    InfoTag(title: "Ano", value: art.objectDate.isEmpty ? "Desconhecido": art.objectDate)
                    InfoTag(title: "Material", value: art.medium)
                }
                
                if !art.tags.isEmpty {
                    WrapTags(tags: art.tags.map { $0.term })
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Local")
                        .font(.headline)
                    Text(art.repository)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(art.country)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if !art.creditLine.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Doado por")
                            .font(.headline)
                        Text(art.creditLine)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Button(action: {
                    viewModel.toggleFavorite()
                }) {
                    HStack {
                        Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                        Text(viewModel.isFavorite ? "Remover dos Favoritos" : "Adicionar aos Favoritos")
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isFavorite ? Color.red : Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .accessibilityIdentifier("favoriteButton")
            }
            .padding()
        }
        .presentationDetents([.medium, .large])
    }
}
