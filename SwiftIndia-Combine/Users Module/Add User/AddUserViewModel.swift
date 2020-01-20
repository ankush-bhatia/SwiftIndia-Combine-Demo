//
//  AddUserViewModel.swift
//  SwiftIndia-Combine
//
//  Created by Ankush Bhatia on 19/01/20.
//  Copyright © 2020 Ankush Bhatia. All rights reserved.
//

import Foundation
import Combine

final class AddUserViewModel: ObservableObject {

    private let manager = Manager()
    private var subscribers = Set<AnyCancellable>()

    let publisher = PassthroughSubject<String, Never>()

    @Published
    var name: String = "" {
        didSet {
            isFetchingData = true
            publisher.send(name)
        }
    }

    @Published
    var isFetchingData: Bool = false
    @Published
    var isRegisteringUser: Bool = false

    @Published
    var isValidName: Bool = false

    @Published
    var alertText: String = ""
    @Published
    var shouldShowAlert: Bool = false

    func commit() {
        publisher
            .debounce(for: .seconds(1.0), scheduler: DispatchQueue.main)

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
                self.isFetchingData = false
            })
            .store(in: &subscribers)
    }

    func registerAndAddUser(in userViewModel: UsersViewModel) {
        isRegisteringUser = true
        manager.addUser(for: name)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    self.alertText = error.localizedDescription
                    self.shouldShowAlert = true
                    self.isRegisteringUser = false
                default:
                    break
                }
            }, receiveValue: { userListViewModel in
                self.isRegisteringUser = false
                userViewModel.users.append(userListViewModel)
            })
            .store(in: &subscribers)
    }
}
