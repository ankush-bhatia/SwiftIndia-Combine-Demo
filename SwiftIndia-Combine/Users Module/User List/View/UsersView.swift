//
//  UsersView.swift
//  SwiftIndia-Combine
//
//  Created by Ankush Bhatia on 05/01/20.
//  Copyright © 2020 Ankush Bhatia. All rights reserved.
//

import SwiftUI

struct UsersView: View {

    // MARK: - Dependencies
    @State private var searchText: String = ""
    @State private var isFetching: Bool = false
    @State private var isSearching: Bool = false
    @ObservedObject var viewModel: UsersViewModel

    // MARK: - Properties
    private let addUserImageName = "plus"

    // MARK: - Body

    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {

                    HStack {
                        UserSearchBar(searchText: self.$searchText,
                                      isFetching: self.$isFetching,
                                      isSearching: self.$isSearching)

                        if self.isFetching {
                            UserAcitivityIndicator()
                        }

                        if self.isSearching {
                            Button(action: {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                self.isSearching = false
                            }) {
                                Text("Done")
                            }
                        }
                    }
                    .padding(.horizontal, 10.0)

                    UserListView(viewModel: self.viewModel, for: self.$searchText)

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
        UsersView(viewModel: viewModel)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
    }
}

extension View {
    func modifiedButton() -> some View {
        ModifiedContent(content: self, modifier: ButtonModifier())
    }
}

struct ButtonModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .frame(width: 200, height: 40, alignment: .center)
            .background(Color.secondary)
            .cornerRadius(4)
            .padding([.top, .bottom], 10)
    }
}

