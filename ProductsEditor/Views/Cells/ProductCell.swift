//
//  ProductCell.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 31/10/2020.
//

import Foundation
import UIKit
import Kingfisher

class ProductCell: UITableViewCell, ReusableView {
    
    static let defaultReuseId = "ProductCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    func setupContent(_ viewState: ProductCellViewState) {
        titleLabel.text = viewState.title
        productImageView.kf.setImage(with: URL(string: viewState.defaultImage))
    }
}
