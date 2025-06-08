//
//  ViewState.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

enum ViewState {
    case loading
    case error(String?)
    case normal([Artwork])
}
