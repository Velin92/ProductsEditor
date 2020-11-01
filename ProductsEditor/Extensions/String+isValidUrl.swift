//
//  String+isValidUrl.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 02/11/2020.
//

import Foundation
import UIKit

extension String {
    
    var isValidUrl: Bool {
        get {
            if let url = URL(string: self), UIApplication.shared.canOpenURL(url) {
                return true
            }
            return false
        }
    }
    
    var asUrl: URL? {
        get {
            if isValidUrl {
                return URL(string: self)
            }
            return nil
        }
    }
}
