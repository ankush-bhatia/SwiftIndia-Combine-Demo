//
//  UserListView.swift
//  SwiftIndia-Combine
//
//  Created by Ankush Bhatia on 06/01/20.
//  Copyright © 2020 Ankush Bhatia. All rights reserved.
//

import SwiftUI

struct UserListView: View {

    var viewModel: [UserListItemViewModel]

    init(viewModel: [UserListItemViewModel]) {
        self.viewModel = viewModel
    }

    var body: some View {
        List(viewModel, id: \.self) { item in
            Text(item.name)
        }
    }
}

struct UserListView_Previews: PreviewProvider {

    @State static private var searchedText = ""

    static var previews: some View {
        let service = UserService()

        let viewModel = UsersViewModel(with: service)
        return UserListView(viewModel: viewModel.users)
    }
}
