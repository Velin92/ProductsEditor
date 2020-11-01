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
}

class ProductDetailPresenter {
    
    typealias ProductDetailView = ProductDetailViewProtocol
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
