//
//  Coordinator.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 31/10/2020.
//

protocol Coordinator: AnyObject {
    func start()
    var child: Coordinator? {get set}
}
