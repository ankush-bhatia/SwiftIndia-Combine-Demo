//
//  AddUserView.swift
//  SwiftIndia-Combine
//
//  Created by Ankush Bhatia on 17/01/20.
//  Copyright © 2020 Ankush Bhatia. All rights reserved.
//

import SwiftUI

struct AddUserView: View {

    // MARK: - Properties
    @ObservedObject private var viewModel: AddUserViewModel
    @ObservedObject private var userViewModel: UsersViewModel

    // MARK: - Initialisers
    init(userViewModel: UsersViewModel) {
        viewModel = AddUserViewModel()
        self.userViewModel = userViewModel
        viewModel.registerUserValidationSearchPublisher()
    }

    // MARK: - Body
    var body: some View {
        VStack {
            HStack {
                TextField("Full Name", text: $viewModel.name, onEditingChanged: { changed in
                }) {
                    print("Return Called")
                }
                .registerationTextfield()

                if viewModel.viewState == AddUserViewState.isFetchingUserValidOrNot {
                    UserAcitivityIndicator(tintColor: .gray)
                }
            }
            Button(action: {
                self.viewModel.registerAndAddUser(in: self.userViewModel)
            }, label: {
                HStack {
                    Text("Submit")
                    if viewModel.viewState == AddUserViewState.isRegisteringUser {
                        UserAcitivityIndicator(tintColor: .white)
                    }
                }
            })
                .modifiedButton()
                .foregroundColor(!$viewModel.isValidName.wrappedValue ? Color.red : Color.green)
                .disabled(!$viewModel.isValidName.wrappedValue)
                .alert(isPresented: $viewModel.shouldShowAlert) {
                    Alert(title: Text("Error"),
                          message: Text($viewModel.alertText.wrappedValue))
            }

            Spacer()
                .navigationBarTitle("Add User")
        }
        .padding()
        .environment(\.colorScheme, .light)
    }
}
