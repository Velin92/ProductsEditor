//
//  ProductDetailViewController.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation
import UIKit

protocol ProductDetailViewProtocol: AnyObject {
    func updateViewState(_ viewState: ProductDetailViewState)
}

class ProductDetailViewController: UIViewController, Storyboarded {
    
    static let storyboardName = "Main"
    static var storyboardId = "ProductDetailViewController"
    
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    
    var presenter: ProductDetailPresenterProtocol!
    let productImagesCollectionViewManager = ProductImagesCollectionViewManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter.loadView()
    }
    
    private func setupCollectionView() {
        productImagesCollectionView.collectionViewLayout = ProductImagesFlowLayout()
        productImagesCollectionView.contentInsetAdjustmentBehavior = .always
        productImagesCollectionView.dataSource = productImagesCollectionViewManager
        productImagesCollectionView.delegate = productImagesCollectionViewManager
        productImagesCollectionView.reloadData()
    }
}

extension ProductDetailViewController: ProductDetailViewProtocol {
    
    func updateViewState(_ viewState: ProductDetailViewState) {
        DispatchQueue.main.async {
            self.productImagesCollectionViewManager.dataSource = viewState.images
            self.productImagesCollectionView.reloadData()
        }
    }
}
