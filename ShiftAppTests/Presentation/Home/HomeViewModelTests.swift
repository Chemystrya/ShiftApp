//
//  HomeViewModelTests.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 06.07.2025.
//

import XCTest
@testable import ShiftApp

final class HomeViewModelTests: XCTestCase {
    private lazy var sut = HomeViewModel(service: productsService, router: router)

    private let router = HomeRouterMock()
    private let productsService = ProductsServiceMock()

    // MARK: - HomeViewModelProtocol

    func testFetchProducts() {
        // Act
        sut.fetchProducts {}

        //Assert
        XCTAssertEqual(productsService.calls, [.fetchProducts])
    }

    func testPresentModalView() {
        // Act
        sut.presentModalView()
        
        //Assert
        XCTAssertEqual(router.calls, [.showModelView])
    }
}

