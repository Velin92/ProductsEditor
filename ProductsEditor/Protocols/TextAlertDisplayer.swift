//
//  TextAlertDisplayer.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation
import UIKit

protocol TextAlertDisplayer: UITextFieldDelegate where Self: UIViewController {
    func showTextAlert(title: String, description: String, placeholder: String, confirmation: String, cancel: String, saveCompletion: @escaping ((String)->Void), cancelCompletion: (()->())?)
    var textAlertUpdater: TextAlertUpdater {get set}
}

extension TextAlertDisplayer {
    
    func showTextAlert(title: String, description: String, placeholder: String, confirmation: String, cancel: String, saveCompletion: @escaping ((String)->Void), cancelCompletion: (()->())?) {
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = placeholder
                textField.clearButtonMode = .whileEditing
                textField.borderStyle = .none
                self.textAlertUpdater.inputTextField = textField
            }
            
            
            let cancelAction = UIAlertAction(title: cancel, style: .cancel, handler: { _ in
              alert.dismiss(animated: true, completion: cancelCompletion)
            })
            alert.addAction(cancelAction)
            
            self.textAlertUpdater.confirmationAction = UIAlertAction(title: confirmation, style: .default, handler: { _ in
                let inputText = self.textAlertUpdater.inputTextField.text
                alert.dismiss(animated: true, completion: {
                    if let inputText = inputText {
                        saveCompletion(inputText)
                    } else {
                        fatalError("inputText should not be nil")
                    }
                })
            })
            self.textAlertUpdater.confirmationAction.isEnabled = false
            alert.addAction(self.textAlertUpdater.confirmationAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}

class TextAlertUpdater {
    weak var inputTextField: UITextField! {
        didSet {
            inputTextField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        }
    }
    
    var confirmationAction: UIAlertAction!
    
    @objc func textDidChange(_ sender: Any) {
        if let text = inputTextField.text, !text.isEmpty {
            confirmationAction.isEnabled = true
        } else {
            confirmationAction.isEnabled = false
        }
    }
}
