//
//  Textfield+Extension.swift
//  SwiftIndia-Combine
//
//  Created by Ankush Bhatia on 22/01/20.
//  Copyright © 2020 Ankush Bhatia. All rights reserved.
//

import Foundation
import SwiftUI

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
