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

    @State private var searchText: String = ""

    @Binding var searchedText: String
    @Binding var isSearching: Bool
    @Binding var isFetching: Bool

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

    func makeCoordinator() -> SearchBarCoordinator {
        let coordinator = SearchBarCoordinator(with: $searchText,
                                               isSearching: $isSearching,
                                               searchTextForApiCall: $searchedText,
                                               isFetching: $isFetching)
        coordinator.debounced()
        return coordinator
    }

}

class SearchBarCoordinator: NSObject, UISearchBarDelegate {
    var text: Binding<String>
    var searchTextForApiCall: Binding<String>
    var isSearching: Binding<Bool>
    var isFetching: Binding<Bool>
    let subject = PassthroughSubject<String, Never>()
    private var subscribers = Set<AnyCancellable>()

    init(with searchText: Binding<String>,
         isSearching: Binding<Bool>,
         searchTextForApiCall: Binding<String>,
         isFetching: Binding<Bool>) {
        self.text = searchText
        self.isSearching = isSearching
        self.searchTextForApiCall = searchTextForApiCall
        self.isFetching = isFetching
    }

    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        text.wrappedValue = searchText
        isSearching.wrappedValue = true
        isFetching.wrappedValue = true
        subject.send(searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching.wrappedValue = false
        searchBar.resignFirstResponder()
    }

    func debounced() {
        subject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { value in
                self.searchTextForApiCall.wrappedValue = value
        }
        .store(in: &subscribers)
    }
}


