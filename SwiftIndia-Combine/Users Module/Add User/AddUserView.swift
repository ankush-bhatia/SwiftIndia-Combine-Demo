//
//  AddUserView.swift
//  SwiftIndia-Combine
//
//  Created by Ankush Bhatia on 17/01/20.
//  Copyright © 2020 Ankush Bhatia. All rights reserved.
//

import SwiftUI

struct AddUserView: View {

    @ObservedObject private var viewModel: AddUserViewModel
    @ObservedObject private var userViewModel: UsersViewModel

    init(userViewModel: UsersViewModel) {
        viewModel = AddUserViewModel()
        self.userViewModel = userViewModel
        viewModel.commit()
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("Full Name", text: $viewModel.name, onEditingChanged: { changed in
                }) {
                    print("Return Called")
                }
                .registerationTextfield()

                if viewModel.isFetchingData {
                    UserAcitivityIndicator()
                }
            }
            Button(action: {
                self.viewModel.registerAndAddUser(in: self.userViewModel)
            }, label: {
                HStack {
                    Text("Submit")
                    if viewModel.isRegisteringUser {
                        UserAcitivityIndicator()
                    }
                }
            })
                .modifiedButton()
                .foregroundColor(!$viewModel.isValidName.wrappedValue ? Color.orange : Color.white)
                .disabled(!$viewModel.isValidName.wrappedValue)

            Spacer()
                .navigationBarTitle("Add User")
        }
        .padding()
        .environment(\.colorScheme, .light)
    }
}

extension TextField {
    func registerationTextfield() -> some View {
        ModifiedContent(content: self, modifier: TextFieldBorder())
    }
}

struct TextFieldBorder: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(height: 25, alignment: .center)
            .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
            .background(Color.white)
            .cornerRadius(10.0)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1.0)
        )
            .foregroundColor(.black)
            .keyboardType(.alphabet)
            .autocapitalization(.words)
            .disableAutocorrection(true)
    }
}
