//
//  ReusableView.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 31/10/2020.
//

import Foundation
import UIKit

protocol ReusableView: UIView {
    static var defaultReuseId: String {get}
}
