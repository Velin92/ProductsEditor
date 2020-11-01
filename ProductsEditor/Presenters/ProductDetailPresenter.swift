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
}

class ProductDetailPresenter {
    
    typealias ProductDetailView = ProductDetailViewProtocol & AlertDisplayer & LoaderDisplayer & TextAlertDisplayer
    weak var view: ProductDetailView!
    let interactor: ProductDetailInteractorProtocol
    
    var viewState = ProductDetailViewState()
    
    init(view: ProductDetailView, interactor: ProductDetailInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    private func updateView() {
        view.updateViewState(self.viewState)
    }
}

extension ProductDetailPresenter: ProductDetailPresenterProtocol {
    func addImage() {
        view.showTextAlert(title: "Add image", description: "Insert a valid image URL", placeholder: "Image URL", confirmation: "Add", cancel: "Cancel", saveCompletion: { [weak self] string in
            if let _ = URL(string: string) {
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
            viewState.operationState = .editing
            updateView()
            view.startEditing()
        }
    }
    
    func browseProduct() {
        if let url = URL(string: interactor.product.url) {
            view.openUrl(url)
        }
    }
    
    func loadView() {
        viewState = ProductDetailViewState(from: interactor.product)
        updateView()
    }
}
