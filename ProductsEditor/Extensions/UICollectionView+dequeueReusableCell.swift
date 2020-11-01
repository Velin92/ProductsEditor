//
//  UICollectionView+dequeueReusableCell.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func dequeueReusableCell<T: ReusableView>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseId, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseId)")
        }
        return cell
    }
}
