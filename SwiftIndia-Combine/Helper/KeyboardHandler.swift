//
//  KeyboardHandler.swift
//  SwiftIndia-Combine
//
//  Created by Ankush Bhatia on 22/01/20.
//  Copyright © 2020 Ankush Bhatia. All rights reserved.
//

import UIKit

enum KeyboardState {
    case isVisible
    case isHidden
}

class KeyboardHandler: ObservableObject {

    @Published
    var height: CGFloat = 0.0

    @Published
    var state: KeyboardState = .isHidden

    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardWillShowNotification(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardDidHideNotification(_:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
    }

    @objc private func handleKeyboardWillShowNotification(_ notification: Notification) {
        state = .isVisible
    }

    @objc private func handleKeyboardDidHideNotification(_ notification: Notification) {
        state = .isHidden
    }
}
