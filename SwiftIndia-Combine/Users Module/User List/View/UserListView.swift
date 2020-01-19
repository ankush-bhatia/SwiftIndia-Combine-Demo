//
//  UserListView.swift
//  SwiftIndia-Combine
//
//  Created by Ankush Bhatia on 06/01/20.
//  Copyright © 2020 Ankush Bhatia. All rights reserved.
//

import SwiftUI

struct UserListView: View {

    @ObservedObject var viewModel: UsersViewModel
    @Binding private var text: String

    init(viewModel: UsersViewModel, for searchedText: Binding<String>) {
        self.viewModel = viewModel
        self._text = searchedText
    }

    var body: some View {
        List(viewModel.users.filter({ itemViewModel -> Bool in
            if text == "" {
                return true
            }
            return itemViewModel.name.lowercased().contains(text.lowercased())
        }), id: \.self, rowContent: { user in
            Text("\(user.name)")
        })
    }
}

struct UserListView_Previews: PreviewProvider {

    @State static private var searchedText = ""

    static var previews: some View {
        let service = UserService()
        
        let viewModel = UsersViewModel(with: service)
        return UserListView(viewModel: viewModel, for: $searchedText)
    }
}
