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
    var addImageClosure: (()->())?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isEditing {
            return dataSource.count + 1
        } else {
            return dataSource.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductImageCell = collectionView.dequeueReusableCell(for: indexPath)
        if indexPath.item < dataSource.count {
            cell.setupContent(dataSource[indexPath.item], isEditing: isEditing)
            cell.deleteClosure = { [weak self] in
                self?.deleteImageClosure?(indexPath.item)
            }
        } else {
            cell.setupAddImageContent()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == dataSource.count {
            addImageClosure?()
        }
    }
}
