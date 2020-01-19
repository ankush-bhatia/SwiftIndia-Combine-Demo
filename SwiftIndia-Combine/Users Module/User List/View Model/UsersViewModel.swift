//
//  UsersViewModel.swift
//  SwiftIndia-Combine
//
//  Created by Ankush Bhatia on 19/01/20.
//  Copyright © 2020 Ankush Bhatia. All rights reserved.
//

import Foundation
import Combine

final class UsersViewModel: ObservableObject {

    // MARK: - Properties
    @Published var users: [UserListItemViewModel] = []
    private let service: UsersServiceProtocol

    private var subscribers = Set<AnyCancellable>()

    // MARK: - Initialisers
    init(with service: UsersServiceProtocol) {
        self.service = service
        fetchUsers()
    }

    // MARK: - Functions
    func fetchUsers() {
        service
            .fetchUsers()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .failure:
                    self?.users = []
                case .finished:
                    break
                }
                }, receiveValue: { [weak self] users in
                    self?.users = users.map({ UserListItemViewModel(with: $0) })
            })
            .store(in: &subscribers)
    }

}
