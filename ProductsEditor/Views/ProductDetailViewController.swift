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

class ProductDetailViewController: UIViewController, Storyboarded, KeyboardDismisser, AlertDisplayer, LoaderDisplayer, TextAlertDisplayer {
    
    static let storyboardName = "Main"
    static var storyboardId = "ProductDetailViewController"
    
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    @IBOutlet weak var productTextView: UITextView!
    @IBOutlet weak var merchantTextView: UITextView!
    @IBOutlet weak var operationButton: UIBarButtonItem!
    @IBOutlet weak var browseButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    
    var presenter: ProductDetailPresenterProtocol!
    let productImagesCollectionViewManager = ProductImagesCollectionViewManager()
    var textAlertUpdater = TextAlertUpdater()
    
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
    
    @IBAction func didTapUndoButton(_ sender: Any) {
        presenter.resetView()
    }
    
    private func setupTextViews() {
        productTextView.delegate = self
        merchantTextView.delegate = self
    }
    
    private func setupCollectionView() {
        productImagesCollectionView.collectionViewLayout = ProductImagesFlowLayout()
        productImagesCollectionView.contentInsetAdjustmentBehavior = .always
        productImagesCollectionView.allowsSelection = true
        productImagesCollectionView.dataSource = productImagesCollectionViewManager
        productImagesCollectionView.delegate = productImagesCollectionViewManager
        productImagesCollectionViewManager.deleteImageClosure =  { [weak self] index in
            self?.presenter.deleteImage(at: index)
        }
        productImagesCollectionViewManager.addImageClosure = { [weak self] in
            self?.presenter.addImage()
        }
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
        productImagesCollectionViewManager.isEditing = false
        operationButton.title = "Edit"
        browseButton.isHidden = false
        deleteButton.isHidden = true
        undoButton.isHidden = true
        updateInfos(productName: viewState.productName, merchantName: viewState.merchantName)
    }
    
    private func updateEditingView(viewState: ProductDetailViewState) {
        productImagesCollectionViewManager.isEditing = true
        browseButton.isHidden = true
        deleteButton.isHidden = false
        undoButton.isHidden = false
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

extension ProductDetailViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view != self.productImagesCollectionView{
            return false
        }else{
            view.endEditing(true)
            return true
        }
    }
}
