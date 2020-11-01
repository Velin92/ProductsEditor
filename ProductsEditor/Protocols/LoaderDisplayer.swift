//
//  LoaderDisplayer.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation
import UIKit

protocol LoaderDisplayer: AnyObject {
    func showLoader()
    func hideLoader()
}

extension LoaderDisplayer where Self: UIViewController {
    func showLoader() {
        DispatchQueue.main.async {
            let maskView = UIView(frame: self.view.frame)
            self.view.addSubview(maskView)
            let activityView: UIActivityIndicatorView
            activityView = UIActivityIndicatorView(style: .large)
            activityView.center = self.view.center
            activityView.startAnimating()
            maskView.tag = String(describing: self).hashValue
            maskView.addSubview(activityView)
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            if let maskView = self.view.subviews.first (where: {$0.tag == String(describing: self).hashValue}) {
                maskView.removeFromSuperview()
            }
        }
    }
}
