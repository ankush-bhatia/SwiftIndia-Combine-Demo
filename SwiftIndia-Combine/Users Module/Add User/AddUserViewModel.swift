//
//  AddUserViewModel.swift
//  SwiftIndia-Combine
//
//  Created by Ankush Bhatia on 19/01/20.
//  Copyright © 2020 Ankush Bhatia. All rights reserved.
//

import Foundation
import Combine

enum AddUserViewState {
    case isFetchingUserValidOrNot
    case isRegisteringUser
    case idle
}

final class AddUserViewModel: ObservableObject {

    // MARK: - Properties
    private var subscribers = Set<AnyCancellable>()

    private let manager = Manager()
    private let userValidationSearchPublisher = PassthroughSubject<String, Never>()

    @Published
    var name: String = "" {
        didSet {
            print(name)
            viewState = .isFetchingUserValidOrNot
            userValidationSearchPublisher.send(name)
        }
    }

    @Published
    var viewState: AddUserViewState = .idle

    @Published
    var isValidName: Bool = false

    @Published
    var alertText: String = ""

    @Published
    var shouldShowAlert: Bool = false

    // MARK: - Functions
    func registerUserValidationSearchPublisher() {
        userValidationSearchPublisher
            .debounce(for: .seconds(1.0), scheduler: DispatchQueue.main)
            .print()
            // Output - String
            // Error - Never
            .flatMap { value in
                return self.manager.isUserNameValid(for: self.name)
        }
            // Output - Bool
            // Error - Never
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { isValid in
                self.isValidName = isValid
                self.viewState = .idle
            })
            .store(in: &subscribers)
    }

    func registerAndAddUser(in userViewModel: UsersViewModel) {
        self.viewState = .isRegisteringUser
        manager.addUser(for: name)
            .print()
            .receive(on: DispatchQueue.main)
            
            // Output Type: UserListItemViewModel
            // Error: UserRegisterationError

//            .catch({ error in
//                Just(UserListItemViewModel(with: User(name: "Placeholder User")))
//            })

//             .retry(2)

            // Output Type: UserListItemViewModel
            // Error: Never
//
//            .mapError({ error in
//                return UserRegisterationError.noInternetConnection
//            })

            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    self.alertText = error.localizedDescription
                    self.shouldShowAlert = true
                    self.viewState = .idle
                default:
                    break
                }
            }, receiveValue: { userListViewModel in
                self.viewState = .idle
                userViewModel.users.append(userListViewModel)
            })
            .store(in: &subscribers)
    }
}
