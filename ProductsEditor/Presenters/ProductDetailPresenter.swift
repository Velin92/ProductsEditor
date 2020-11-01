//
//  ProductDetailPresenter.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation

protocol ProductDetailPresenterProtocol: AnyObject {
    func loadView()
}

class ProductDetailPresenter {
    
    typealias ProductDetailView = ProductDetailViewProtocol
    weak var view: ProductDetailView!
    let interactor: ProductDetailInteractorProtocol
    
    var viewState = ProductDetailViewState(images: [])
    
    init(view: ProductDetailView, interactor: ProductDetailInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    private func updateView() {
        view.updateViewState(self.viewState)
    }
}

extension ProductDetailPresenter: ProductDetailPresenterProtocol {
    func loadView() {
        viewState.images = interactor.product.images
        updateView()
    }
}
