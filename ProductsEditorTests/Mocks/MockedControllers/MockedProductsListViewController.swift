//
//  MockedProductsListViewController.swift
//  ProductsEditorTests
//
//  Created by Mauro Romito on 02/11/2020.
//

import Foundation
import UIKit
@testable import ProductsEditor

class MockedProductsListViewController: UIViewController, ProductsListViewProtocol, LoaderDisplayer, AlertDisplayer {
    
    var viewState: ProductsListViewState?
    
    var alertTitle: String?
    var alertDescription: String?
    
    func updateViewState(_ viewState: ProductsListViewState) {
        print(viewState)
        self.viewState = viewState
    }
    
    func showAlert(title: String, description: String) {
        self.alertTitle = title
        self.alertDescription = description
    }
}
