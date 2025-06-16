//
//  ArtCardView.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 16/06/25.
//

import SwiftUI

public struct ArtCard: View {
    private let art: ArtObject
    
    init(art: ArtObject) {
        self.art = art
    }
    
    public var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: art.primaryImageSmall)) { phase in
                switch phase {
                case .empty:
                    Color.gray.opacity(0.2)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 32, height: 400)
                        .clipped()
                case .failure:
                    Color.gray.opacity(0.2)
                @unknown default:
                    Color.gray.opacity(0.2)
                }
            }
            
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0.7), .clear]),
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(height: 120)
            .allowsHitTesting(false)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(art.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(2)
                
                Text(art.artistDisplayName.isEmpty ? "Desconhecido" : art.artistDisplayName)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(1)
            }
            .padding()
        }
        .frame(height: 400)
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}
