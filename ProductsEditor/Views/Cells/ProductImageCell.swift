//
//  ProductImageCell.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation
import UIKit
import Kingfisher

class ProductImageCell: UICollectionViewCell, ReusableView {
    
    static let defaultReuseId = "ProductImageCell"
    
    @IBOutlet weak var productImageView: UIImageView!
    
    
    func setupContent(_ url: String) {
        productImageView.kf.setImage(with: URL(string: url))
    }
    
}
