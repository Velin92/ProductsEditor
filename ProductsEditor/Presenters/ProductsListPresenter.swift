//
//  ProductsListPresenter.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 31/10/2020.
//

import Foundation

protocol ProductsListPresenterProtocol: AnyObject {
    func loadProducts()
}

class ProductsListPresenter {
    
    typealias ProductsListView = ProductsListViewProtocol & LoaderDisplayer
    
    weak var view: ProductsListView!
    let interactor: ProductsListInteractorProtocol
    
    var viewState: ProductsListViewState = []
    
    init(view: ProductsListView, interactor: ProductsListInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    private func updateView() {
        view.updateViewState(self.viewState)
    }
}

extension ProductsListPresenter: ProductsListPresenterProtocol {
    
    func loadProducts() {
        view.showLoader()
        interactor.fetchProducts(skip: 0, bulk: 100) { [weak self] result in
            self?.view.hideLoader()
            switch result {
            case .success(let products):
                self?.viewState = products.map(ProductCellViewState.init)
                self?.updateView()
            case .failure(let error):
                break
            }
        }
    }
}
