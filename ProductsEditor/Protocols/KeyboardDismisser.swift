//
//  KeyboardDismisser.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation
import UIKit

protocol KeyboardDismisser {
    func setupDismissKeyboardGesture()
}

extension KeyboardDismisser where Self: UIViewController & UIGestureRecognizerDelegate {
    func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_ :)))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
}
