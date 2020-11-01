//
//  AlertDisplayer.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation
import UIKit

protocol AlertDisplayer where Self: UIViewController {
    func showAlert(title: String, description: String)
    func showAlert(title: String, description: String, confirmation: String, cancel: String, isDestructive: Bool, confirmCompletion: (()->())?, cancelCompletion: (()->())?)
}

extension AlertDisplayer  {
    func showAlert(title: String, description: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlert(title: String, description: String, confirmation: String, cancel: String, isDestructive: Bool, confirmCompletion: (()->())?, cancelCompletion: (()->())?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: cancel, style: .cancel, handler: { _ in
                alert.dismiss(animated: true, completion: cancelCompletion)
            })
            
            alert.addAction(cancelAction)
            
            let confirmAction = UIAlertAction(title: confirmation, style: isDestructive ? .destructive : .default, handler: { _ in
                alert.dismiss(animated: true, completion: confirmCompletion)
            })
            
            alert.addAction(confirmAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
