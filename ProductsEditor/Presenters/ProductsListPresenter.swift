//
//  ProductsListPresenter.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 31/10/2020.
//

import Foundation

protocol ProductsListPresenterProtocol: AnyObject {
    
}

class ProductsListPresenter {
    
    typealias ProductsListView = ProductsListViewProtocol
    
    weak var view: ProductsListView!
    let interactor: ProductsListInteractorProtocol
    
    init(view: ProductsListView, interactor: ProductsListInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
}

extension ProductsListPresenter: ProductsListPresenterProtocol {
    
}
