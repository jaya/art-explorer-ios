//
//  ArtListView.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 15/06/25.
//

import SwiftUI

struct ArtListView: View {
    @ObservedObject var viewModel: ArtListViewModel
    @State private var isShowingSheet = false
    @State private var selectedArt: ArtObject?
    @State private var showFavorites: Bool = false
    @State private var firstLoadDone = false
    
    let makeDetail: (ArtObject) -> ArtDetailView
    
    var body: some View {
        NavigationView {
            ZStack {
                if let error = viewModel.error {
                    VStack(spacing: 16) {
                        Text("Erro ao carregar obras: \(error)")
                            .font(.title3)
                            .foregroundColor(.red)
                        Text(error)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                        Button("Tentar novamente") {
                            Task {
                                await (showFavorites
                                    ? viewModel.loadFavoritesInitial()
                                    : viewModel.loadInitial())
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(viewModel.artworks) { art in
                                ArtCard(art: art)
                                    .onTapGesture {
                                        selectedArt = art
                                        isShowingSheet = true
                                    }
                            }

                            if viewModel.isLoading && !viewModel.artworks.isEmpty {
                                ProgressView()
                                    .padding()
                            } else if !viewModel.isLoading {
                                Color.clear
                                    .frame(height: 1)
                                    .onAppear {
                                        Task {
                                            await viewModel.loadMore()
                                        }
                                    }
                            }
                        }
                        .padding(.vertical)
                    }
                }

                if viewModel.artworks.isEmpty && viewModel.isLoading {
                    ProgressView("Carregando obras...")
                        .scaleEffect(1.2)
                        .padding()
                }
            }
            .sheet(item: $selectedArt) { art in
                makeDetail(art)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
            .navigationTitle(showFavorites ? "Favoritos" : "Art Explorer")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(showFavorites ? "Ver Tudo" : "Ver Favoritos") {
                        showFavorites.toggle()
                        Task {
                                await MainActor.run { viewModel.clearArtworks() }
                                if showFavorites {
                                    await viewModel.loadFavoritesInitial()
                                } else {
                                    await viewModel.loadInitial()
                                }
                            }
                    }
                }
            }
            .onAppear {
                guard !firstLoadDone else { return }
                firstLoadDone = true
                Task { await viewModel.loadInitial() }
            }
            .background(Color(.systemBackground))
        }
    }
}
