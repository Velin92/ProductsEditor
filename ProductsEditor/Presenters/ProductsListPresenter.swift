//
//  ProductsListPresenter.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 31/10/2020.
//

import Foundation

protocol ProductsListPresenterProtocol: AnyObject {
    func loadProducts()
    func didSelectProduct(at index: Int)
    func addNewProduct()
    func loadNextPage()
}

class ProductsListPresenter {
    
    typealias ProductsListView = ProductsListViewProtocol & LoaderDisplayer & AlertDisplayer
    
    weak var view: ProductsListView!
    let interactor: ProductsListInteractorProtocol
    
    var goToProductDetailClosure: ((Product?)->())?
    
    var viewState: ProductsListViewState = []
    
    var currentPage = 1
    let bulk = 10
    var isLoadingNextPage = false
    
    init(view: ProductsListView, interactor: ProductsListInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    private func updateView() {
        view.updateViewState(self.viewState)
    }
}

extension ProductsListPresenter: ProductsListPresenterProtocol {
    func loadNextPage() {
        guard !isLoadingNextPage else {
            return
        }
        isLoadingNextPage = true
        view.showLoader()
        interactor.fetchProducts(skip: 0, bulk: (currentPage + 1) * bulk) { [unowned self] result in
            self.isLoadingNextPage = false
            self.view.hideLoader()
            switch result {
            case .success(let products):
                if products.count > self.viewState.count {
                    self.currentPage += 1
                }
                print("Current page: \(self.currentPage)")
                self.viewState = products.map(ProductCellViewState.init)
                self.updateView()
            case .failure(let error):
                self.handleError(error: error)
            }
        }
    }
    
    private func handleError(error: ProductsListError) {
        switch error {
        case .empty:
            print("Empty list")
        case .genericError:
            view.showAlert(title: "Alert", description: "An error has occurred")
        }
    }
    
    
    func addNewProduct() {
        goToProductDetailClosure?(nil)
    }
    
    func didSelectProduct(at index: Int) {
        let product = interactor.getProduct(at: index)
        goToProductDetailClosure?(product)
    }

    func loadProducts() {
        view.showLoader()
        interactor.fetchProducts(skip: 0, bulk: currentPage * bulk) { [weak self] result in
            self?.view.hideLoader()
            switch result {
            case .success(let products):
                self?.viewState = products.map(ProductCellViewState.init)
                self?.updateView()
            case .failure(let error):
                self?.handleError(error: error)

            }
        }
    }
}
