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

    // MARK: - Properties
    var tintColor: UIColor

    // MARK: - Functions
    func makeUIView(context: UIViewRepresentableContext<UserAcitivityIndicator>) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = tintColor
        return activityIndicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<UserAcitivityIndicator>) {
        uiView.startAnimating()
    }

}
