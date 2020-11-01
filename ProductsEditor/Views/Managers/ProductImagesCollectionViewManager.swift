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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductImageCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setupContent(dataSource[indexPath.item])
        return cell
    }
}
