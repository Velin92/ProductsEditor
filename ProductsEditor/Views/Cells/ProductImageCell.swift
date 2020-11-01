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
    @IBOutlet weak var deleteButton: UIButton!
    
    var deleteClosure: (()->())?
    
    func setupContent(_ url: String, isEditing: Bool) {
        productImageView.kf.setImage(with: URL(string: url))
        deleteButton.isHidden = !isEditing
    }
    
    func setupAddImageContent() {
        productImageView.image = UIImage(systemName: "plus")
        deleteButton.isHidden =  true
    }
    
    @IBAction func didTapDeleteButton(_ sender: Any) {
        deleteClosure?()
    }
}
