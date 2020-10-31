//
//  ViewController.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 31/10/2020.
//

import UIKit

protocol ProductsListViewProtocol: AnyObject {
    
}

class ProductsListViewController: UIViewController, Storyboarded {
    
    static let storyboardName = "Main"
    static let storyboardId = "ProductsListViewController"
    
    @IBOutlet weak var productsTableView: UITableView!
    
    var presenter: ProductsListPresenterProtocol!
    let productsListManager = ProductsListTableViewManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
    }
    
    private func setupTableView() {
        productsTableView.delegate = productsListManager
        productsTableView.dataSource = productsListManager
        productsTableView.reloadData()
    }
}

extension ProductsListViewController: ProductsListViewProtocol {
    
}

