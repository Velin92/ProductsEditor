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
    func openUrl(_ url: URL)
}

class ProductDetailViewController: UIViewController, Storyboarded {
    
    static let storyboardName = "Main"
    static var storyboardId = "ProductDetailViewController"
    
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    @IBOutlet weak var productTextView: UITextView!
    @IBOutlet weak var merchantTextView: UITextView!
    
    var presenter: ProductDetailPresenterProtocol!
    let productImagesCollectionViewManager = ProductImagesCollectionViewManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter.loadView()
    }
    
    @IBAction func didTapBrowseButton(_ sender: Any) {
        presenter.browseProduct()
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
    
    func openUrl(_ url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func updateViewState(_ viewState: ProductDetailViewState) {
        DispatchQueue.main.async {
            self.updateCollectionView(with: viewState.images)
            self.updateInfos(productName: viewState.productName, merchantName: viewState.merchantName)
        }
    }
    
    private func updateCollectionView(with images: [String]) {
        self.productImagesCollectionViewManager.dataSource = images
        self.productImagesCollectionView.reloadData()
    }
    
    private func updateInfos(productName: String, merchantName: String) {
        self.productTextView.text = productName
        self.merchantTextView.text = merchantName
    }
}
