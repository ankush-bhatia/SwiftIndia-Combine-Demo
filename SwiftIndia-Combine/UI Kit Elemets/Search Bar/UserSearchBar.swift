//
//  UserSearchBar.swift
//  SwiftIndia-Combine
//
//  Created by Ankush Bhatia on 06/01/20.
//  Copyright © 2020 Ankush Bhatia. All rights reserved.
//

import SwiftUI
import Combine

// Need to implement because SearchBar is not available in Swift UI right now.
struct UserSearchBar: UIViewRepresentable {

    typealias UIViewType = UISearchBar

    // MARK: - Properties
    @State private var searchText: String = ""

    @Binding var searchedTextForApiCall: String
    @Binding var viewState: UserViewState

    // MARK: - Functions
    func makeUIView(context: UIViewRepresentableContext<UserSearchBar>) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search Here..."
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar,
                      context: UIViewRepresentableContext<UserSearchBar>) {
        uiView.text = searchText
    }

    // MARK: - Coordinator
    func makeCoordinator() -> SearchBarCoordinator {
        let coordinator = SearchBarCoordinator(with: $searchText,
                                               searchTextForApiCall: $searchedTextForApiCall,
                                               viewState: $viewState)
        coordinator.registerSearchPublisher()
        return coordinator
    }

}
