//
//  SearchBarCoordinator.swift
//  SwiftIndia-Combine
//
//  Created by Ankush Bhatia on 22/01/20.
//  Copyright © 2020 Ankush Bhatia. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import Combine

class SearchBarCoordinator: NSObject {

    // MARK: - Properties
    var searchText: Binding<String>
    var searchTextForApiCall: Binding<String>
    var viewState: Binding<UserViewState>

    private let searchPublisher = PassthroughSubject<String, Never>()
    private var subscribers = Set<AnyCancellable>()

    // MARK: - Initialisers
    init(with searchText: Binding<String>,
         searchTextForApiCall: Binding<String>,
         viewState: Binding<UserViewState>) {
        self.searchText = searchText
        self.searchTextForApiCall = searchTextForApiCall
        self.viewState = viewState
    }

    // MARK: - Function
    func registerSearchPublisher() {
        searchPublisher
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { value in
                self.searchTextForApiCall.wrappedValue = value
        }
        .store(in: &subscribers)
    }
}

// MARK: - UISearchBarDelegate
extension SearchBarCoordinator: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        self.searchText.wrappedValue = searchText
        self.viewState.wrappedValue = UserViewState.searching
        searchPublisher.send(searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewState.wrappedValue = UserViewState.idle
        searchBar.resignFirstResponder()
    }
}
