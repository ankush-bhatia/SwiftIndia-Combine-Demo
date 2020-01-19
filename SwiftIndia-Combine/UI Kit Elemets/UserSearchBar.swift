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
    @Binding var searchText: String
    @Binding var isFetching: Bool
    @Binding var isSearching: Bool

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
        let coordinator = SearchBarCoordinator(with: $searchText, isFetchingData: $isFetching, isSearching: $isSearching)
        coordinator.debounced()
        return coordinator
    }

}

class SearchBarCoordinator: NSObject, UISearchBarDelegate {
    var text: Binding<String>
    var isFetchingData: Binding<Bool>
    var isSearching: Binding<Bool>
    let subject = PassthroughSubject<String, Never>()
    private var subscribers = Set<AnyCancellable>()

    init(with searchText: Binding<String>,
         isFetchingData: Binding<Bool>,
         isSearching: Binding<Bool>) {
        self.text = searchText
        self.isFetchingData = isFetchingData
        self.isSearching = isSearching
    }

    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        isFetchingData.wrappedValue = true
        subject.send(searchText)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching.wrappedValue = true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching.wrappedValue = false
        searchBar.resignFirstResponder()
    }

    func debounced() {
        subject
            .debounce(for: .seconds(1.0), scheduler: DispatchQueue.main)
            .sink { value in
                self.text.wrappedValue = value
                self.isFetchingData.wrappedValue = false
        }
        .store(in: &subscribers)
    }
}


