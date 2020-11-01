//
//  ProductDetailViewController.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation
import UIKit

protocol ProductDetailViewProtocol {
    
}

class ProductDetailViewController: UIViewController, Storyboarded {
    
    static let storyboardName = "Main"
    static var storyboardId = "ProductDetailViewController"
    
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    
}

extension ProductDetailViewController: ProductDetailViewProtocol {
    
}
