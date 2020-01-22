//
//  UsersView.swift
//  SwiftIndia-Combine
//
//  Created by Ankush Bhatia on 05/01/20.
//  Copyright © 2020 Ankush Bhatia. All rights reserved.
//

import SwiftUI

struct UsersView: View {

    // MARK: - Properties
    @ObservedObject var keyboardHandler: KeyboardHandler
    @ObservedObject var viewModel: UsersViewModel

    private let addUserImageName = "plus"

    // MARK: - Body
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {

                    HStack {
                        UserSearchBar(searchedTextForApiCall: self.$viewModel.searchedText,
                                      viewState: self.$viewModel.viewState)

                        if self.viewModel.viewState == .fetchingData ||
                            self.viewModel.viewState == .searching {
                            UserAcitivityIndicator(tintColor: .gray)
                        }

                        if self.keyboardHandler.state == .isVisible {
                            Button(action: {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }) {
                                Text("Done")
                            }
                        }
                    }
                    .padding(.horizontal, 10.0)

                    UserListView(viewModel: self.viewModel.users)

                    NavigationLink(destination: AddUserView(userViewModel: self.viewModel)) {
                        HStack {
                            Text("Add User")
                            Image(systemName: self.addUserImageName)
                        }
                        .padding(.vertical)
                        .modifiedButton()
                        .foregroundColor(.white)
                    }

                }
            }
            .navigationBarTitle("Users")
        }
        .environment(\.colorScheme, .light)
    }

}

struct ContentView_Previews: PreviewProvider {
    static let viewModel = UsersViewModel(with: UserService())
    static var previews: some View {
        UsersView(keyboardHandler: KeyboardHandler(), viewModel: viewModel)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
    }
}
