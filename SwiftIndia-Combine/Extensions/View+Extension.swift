//
//  View+Extension.swift
//  SwiftIndia-Combine
//
//  Created by Ankush Bhatia on 22/01/20.
//  Copyright © 2020 Ankush Bhatia. All rights reserved.
//

import Foundation
import SwiftUI

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
