//
//  UserAcitivityIndicator.swift
//  SwiftIndia-Combine
//
//  Created by Ankush Bhatia on 19/01/20.
//  Copyright © 2020 Ankush Bhatia. All rights reserved.
//

import SwiftUI
import Foundation

struct UserAcitivityIndicator: UIViewRepresentable {

    typealias UIViewType = UIActivityIndicatorView


    func makeUIView(context: UIViewRepresentableContext<UserAcitivityIndicator>) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        return activityIndicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<UserAcitivityIndicator>) {
        uiView.startAnimating()
    }

}
