//
//  UITableView+dequeueReusableCell.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 31/10/2020.
//

import Foundation
import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: ReusableView>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseId, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseId)")
        }
        return cell
    }
}

