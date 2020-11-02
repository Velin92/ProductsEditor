//
//  ProductsListTableViewManager.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 31/10/2020.
//

import Foundation
import UIKit

class ProductsListTableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var dataSource: [ProductCellViewState] = []
    
    var didSelectRowClosure: ((Int)->())?
    var didReachEnd: (()->())?
    var isWatingDecelerationEnd = false
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupContent(dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowClosure?(indexPath.row)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isWatingDecelerationEnd = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height && !isWatingDecelerationEnd {
            isWatingDecelerationEnd = true
            didReachEnd?()
        }
    }
}
