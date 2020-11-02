//
//  ViewController.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 31/10/2020.
//

import UIKit

protocol ProductsListViewProtocol: AnyObject {
    func updateViewState(_ viewState: ProductsListViewState)
}

class ProductsListViewController: UIViewController, Storyboarded, LoaderDisplayer, AlertDisplayer {
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadProducts()
    }
    
    @IBAction func didTapAddButton(_ sender: Any) {
        presenter.addNewProduct()
    }
    
    @IBAction func didTapRefreshButton(_ sender: Any) {
        presenter.loadProducts()
    }
    
    private func setupTableView() {
        productsTableView.delegate = productsListManager
        productsTableView.dataSource = productsListManager
        productsListManager.didSelectRowClosure = { [weak self] index in
            self?.presenter.didSelectProduct(at: index)
        }
        productsListManager.didReachEnd = { [weak self] in
            self?.presenter.loadNextPage()
        }
        productsTableView.reloadData()
    }
}

extension ProductsListViewController: ProductsListViewProtocol {
    
    func updateViewState(_ viewState: ProductsListViewState) {
        DispatchQueue.main.async {
            self.productsListManager.dataSource = viewState
            self.productsTableView.reloadData()
        }
    }
}

