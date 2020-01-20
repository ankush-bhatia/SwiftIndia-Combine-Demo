//
//  UserListItemViewModel.swift
//  SwiftIndia-Combine
//
//  Created by Ankush Bhatia on 19/01/20.
//  Copyright © 2020 Ankush Bhatia. All rights reserved.
//

import Foundation

final class UserListItemViewModel: Hashable, Equatable {

    var name: String = ""
    let id = UUID()

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(with user: User) {
        name = user.name
    }

    static func == (lhs: UserListItemViewModel, rhs: UserListItemViewModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
