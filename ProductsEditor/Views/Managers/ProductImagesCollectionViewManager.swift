//
//  ProductImagesCollectionViewManager.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation
import UIKit

class ProductImagesCollectionViewManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var dataSource: [String] = []
    var isEditing = false
    
    var deleteImageClosure: ((Int)->())?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductImageCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setupContent(dataSource[indexPath.item], isEditing: isEditing)
        cell.deleteClosure = { [weak self] in
            self?.deleteImageClosure?(indexPath.item)
        }
        return cell
    }
}
