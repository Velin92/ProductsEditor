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
        navigationController.pushViewController(vc, animated: false)
    }
}
