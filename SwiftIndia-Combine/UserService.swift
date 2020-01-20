//
//  UserService.swift
//  SwiftIndia-Combine
//
//  Created by Ankush Bhatia on 19/01/20.
//  Copyright © 2020 Ankush Bhatia. All rights reserved.
//

import Foundation
import Combine

protocol UsersServiceProtocol {
    func fetchUsers(for searchedText: String) -> Future<[User], Never>
}

struct UserService: UsersServiceProtocol {
    func fetchUsers(for searchedText: String) -> Future<[User], Never> {
        let users = [
            User(name: "Ankush Bhatia"),
            User(name: "Rajesh"),
            User(name: "Ramesh"),
            User(name: "John"),
            User(name: "John"),
            User(name: "Katy"),
            User(name: "User"),
            User(name: "User1"),
            User(name: "Bot"),
            User(name: "Bot1")
        ]

        // Creating future publisher
        let future = Future<[User], Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) {
                if searchedText == "" {
                    promise(.success(users))
                } else {
                    let users = users.filter({ $0.name.lowercased().contains(searchedText.lowercased()) })
                    promise(.success(users))
                }
            }
        }

        return future
    }

}
