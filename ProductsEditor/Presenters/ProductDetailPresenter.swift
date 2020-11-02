//
//  ProductDetailPresenter.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation

protocol ProductDetailPresenterProtocol: AnyObject {
    func loadView()
    func browseProduct()
    func manageOperation()
    func deleteImage(at index: Int)
    func resetView()
    func addImage()
    func updateDetails(name: String?, merchant: String?, url: String?)
    func delete()
}

class ProductDetailPresenter {
    
    typealias ProductDetailView = ProductDetailViewProtocol & AlertDisplayer & LoaderDisplayer & TextAlertDisplayer
    weak var view: ProductDetailView!
    let interactor: ProductDetailInteractorProtocol
    var viewState = ProductDetailViewState()
    
    var goBackClosure: (()->())?
    
    init(view: ProductDetailView, interactor: ProductDetailInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    private func updateView() {
        view.updateViewState(self.viewState)
    }
}

extension ProductDetailPresenter: ProductDetailPresenterProtocol {
    
    func delete() {
        view.showAlert(title: "Delete", description: "Are you sure you want to delete this product? This operation cannot be undone", confirmation: "Delete", cancel: "Cancel", isDestructive: true, confirmCompletion: { [weak self] in
            self?.executeDelete()
        }, cancelCompletion: nil)
    }
    
    private func executeDelete() {
        interactor.deleteProduct() { [weak self] result in
            switch result {
            case .success:
                self?.goBackClosure?()
            case .failure:
                self?.view.showAlert(title: "Alert", description: "Could not complete the operation")
            }
        }
    }
    
    func updateDetails(name: String?, merchant: String?, url: String?){
        guard let name = name,
              !name.isEmpty,
              let url = url,
              url.isValidUrl else {
            view.showAlert(title: "Alert", description: "The name must be non empty and the URL value mast be a valid URL")
            return
        }
        view.showLoader()
        interactor.updateProduct(name: name, merchant: merchant ?? "", url: url, images: viewState.images) { [weak self] result in
            self?.view.hideLoader()
            switch result {
            case .success:
                self?.loadView()
            case .failure:
                self?.view.showAlert(title: "Alert", description: "Could not complete the operation")
            }
        }
    }
    
    func addImage() {
        view.showTextAlert(title: "Add image", description: "Insert a valid image URL", placeholder: "Image URL", confirmation: "Add", cancel: "Cancel", saveCompletion: { [weak self] string in
            if string.isValidUrl {
                self?.viewState.images.append(string)
                self?.updateView()
            } else {
                self?.view.showAlert(title: "Alert", description: "Invalid URL")
            }
        }, cancelCompletion: nil)
    }
    
    func resetView() {
        view.showAlert(title: "Undo", description: "Are you sure you want to undo the editing operation?", confirmation: "Undo", cancel: "Cancel", isDestructive: false, confirmCompletion: { [weak self] in
            self?.loadView()
        }, cancelCompletion: nil)
    }
    
    func deleteImage(at index: Int) {
        viewState.images.remove(at: index)
        updateView()
    }
    
    func manageOperation() {
        if (viewState.operationState == .displaying) {
            editOperation()
        } else {
            saveOperation()
        }
    }
    
    private func editOperation() {
        viewState.operationState = .editing
        updateView()
        view.startEditing()
    }
    
    private func saveOperation() {
        view.requestDetails()
    }
    
    func browseProduct() {
        if let product = interactor.product, let url = product.url.asUrl {
            view.openUrl(url)
        }
    }
    
    func loadView() {
        if let product = interactor.product {
            viewState = ProductDetailViewState(from: product)
        } else {
            viewState = ProductDetailViewState()
        }
        updateView()
    }
}
