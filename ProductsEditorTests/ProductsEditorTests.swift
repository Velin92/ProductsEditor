//
//  ProductsEditorTests.swift
//  ProductsEditorTests
//
//  Created by Mauro Romito on 31/10/2020.
//

import XCTest
@testable import ProductsEditor

class ProductsEditorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testInvalidProductList() throws {
        let mockService = MockedService(mockedJson: "invalidProductList", isFailureTest: false)
        let mockVc = MockedProductsListViewController()
        let interactor = ProductsListInteractor(service: mockService)
        let presenter = ProductsListPresenter(view: mockVc, interactor: interactor)
        presenter.loadProducts()
        XCTAssert(mockVc.viewState != nil)
        XCTAssert(mockVc.viewState?.isEmpty ?? false)
        XCTAssert(mockVc.alertTitle == nil)
        XCTAssert(mockVc.alertDescription == nil)
    }
    
    func testErrorProductList() throws {
        let mockService = MockedService(mockedJson: "", isFailureTest: true)
        let mockVc = MockedProductsListViewController()
        let interactor = ProductsListInteractor(service: mockService)
        let presenter = ProductsListPresenter(view: mockVc, interactor: interactor)
        presenter.loadProducts()
        XCTAssert(mockVc.alertTitle != nil)
        XCTAssert(mockVc.alertDescription != nil)
    }
    
    func testSuccesfulProductList() throws {
        let mockService = MockedService(mockedJson: "validProductList", isFailureTest: false)
        let mockVc = MockedProductsListViewController()
        let interactor = ProductsListInteractor(service: mockService)
        let presenter = ProductsListPresenter(view: mockVc, interactor: interactor)
        presenter.loadProducts()
        XCTAssert(mockVc.alertTitle == nil)
        XCTAssert(mockVc.alertDescription == nil)
        XCTAssert(mockVc.viewState != nil)
        if let viewState = mockVc.viewState {
            XCTAssert(viewState.count == 3)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
