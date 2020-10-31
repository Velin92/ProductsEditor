//
//  Storyboarded.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 31/10/2020.
//

import Foundation
import UIKit

protocol Storyboarded: UIViewController {
        
    static func instantiate() -> Self
    
    static var storyboardName: String {get}
    static var storyboardId: String {get}
}

extension Storyboarded {
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: storyboardId)
    }
    
}
