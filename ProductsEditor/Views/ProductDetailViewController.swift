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
    func startEditing()
}

class ProductDetailViewController: UIViewController, Storyboarded, KeyboardDismisser {
    
    static let storyboardName = "Main"
    static var storyboardId = "ProductDetailViewController"
    
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    @IBOutlet weak var productTextView: UITextView!
    @IBOutlet weak var merchantTextView: UITextView!
    @IBOutlet weak var operationButton: UIBarButtonItem!
    @IBOutlet weak var browseButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var presenter: ProductDetailPresenterProtocol!
    let productImagesCollectionViewManager = ProductImagesCollectionViewManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextViews()
        setupDismissKeyboardGesture()
        setupCollectionView()
        presenter.loadView()
    }
    
    @IBAction func didTapBrowseButton(_ sender: Any) {
        presenter.browseProduct()
    }
    
    @IBAction func didTapOnOperationButton(_ sender: Any) {
        presenter.manageOperation()
    }
    
    @IBAction func didTapDeleteButton(_ sender: Any) {
    }
    
    private func setupTextViews() {
        productTextView.delegate = self
        merchantTextView.delegate = self
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
    
    func startEditing() {
        DispatchQueue.main.async {
            self.productTextView.becomeFirstResponder()
        }
    }
    
    func openUrl(_ url: URL) {
        DispatchQueue.main.async {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func updateViewState(_ viewState: ProductDetailViewState) {
        DispatchQueue.main.async {
            self.updateCollectionView(with: viewState.images)
            if (viewState.operationState == .displaying) {
                self.updateDisplayingView(viewState: viewState)
            } else {
                self.updateEditingView(viewState: viewState)
            }
        }
    }
    
    private func updateCollectionView(with images: [String]) {
        self.productImagesCollectionViewManager.dataSource = images
        self.productImagesCollectionView.reloadData()
    }
    
    private func updateInfos(productName: String, merchantName: String) {
        productTextView.isEditable = false
        merchantTextView.isEditable = false
        productTextView.backgroundColor = .systemBackground
        merchantTextView.backgroundColor = .systemBackground
        productTextView.text = productName
        merchantTextView.text = merchantName
    }
    
    private func updateDisplayingView(viewState: ProductDetailViewState) {
        operationButton.title = "Edit"
        browseButton.isHidden = false
        deleteButton.isHidden = true
        updateInfos(productName: viewState.productName, merchantName: viewState.merchantName)
    }
    
    private func updateEditingView(viewState: ProductDetailViewState) {
        browseButton.isHidden = true
        deleteButton.isHidden = false
        operationButton.title = "Done"
        productTextView.isEditable = true
        merchantTextView.isEditable = true
        productTextView.backgroundColor = .secondarySystemFill
        merchantTextView.backgroundColor = .secondarySystemFill
    }
}

extension ProductDetailViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n")
        {
            let nextTag = textView.tag + 1
            
            if let nextResponder = textView.superview?.viewWithTag(nextTag) {
                nextResponder.becomeFirstResponder()
            } else {
                textView.resignFirstResponder()
            }
            return false
        }
        else
        {
            return true
        }
    }
}
