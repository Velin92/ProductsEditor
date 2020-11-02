//
//  MainCoordinator.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 31/10/2020.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var child: Coordinator?
    
    private weak var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ProductsListViewController.instantiate()
        let interactor = ProductsListInteractor(service: APIClient())
        let presenter = ProductsListPresenter(view: vc, interactor: interactor)
        
        presenter.goToProductDetailClosure = {
            [weak self] product in
            self?.goToProductDetail(with: product)
        }
        
        vc.presenter = presenter
        navigationController.pushViewController(vc, animated: false)
    }
    
    private func goToProductDetail(with product: Product) {
        let vc = ProductDetailViewController.instantiate()
        let interactor = ProductDetailInteractor(model: product, service: APIClient())
        let presenter = ProductDetailPresenter(view: vc, interactor: interactor)
        presenter.goBackClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: true)
            }
        }
        vc.presenter = presenter
        DispatchQueue.main.async {
            self.navigationController.pushViewController(vc, animated: true)
        }
    }
    
}
