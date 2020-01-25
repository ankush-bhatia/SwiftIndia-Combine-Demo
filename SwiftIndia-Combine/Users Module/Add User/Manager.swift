//
//  Manager.swift
//  SwiftIndia-Combine
//
//  Created by Ankush Bhatia on 19/01/20.
//  Copyright © 2020 Ankush Bhatia. All rights reserved.
//

import Foundation
import Combine

enum UserRegisterationError: Error {
    case unableToRegister
    case noInternetConnection

    var localizedDescription: String {
        switch self {
        case .unableToRegister:
            return "Unable to register the user."
        case .noInternetConnection:
            return "Please check your internet connection."
        }
    }
}

class Manager {

    // API Call
    func isUserNameValid(for name: String) -> Future<Bool, Never> {
        let future = Future<Bool, Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
                promise(.success(name.count > 7))
            }
        }
        return future
    }

    func addUser(for name: String) -> Future<UserListItemViewModel, UserRegisterationError> {
        let future = Future<UserListItemViewModel, UserRegisterationError> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
                let user = User(name: name)
                let userListItemViewModel = UserListItemViewModel(with: user)
                promise(.success(userListItemViewModel))
                //promise(.failure(.unableToRegister))
            }
        }
        return future
    }

}
