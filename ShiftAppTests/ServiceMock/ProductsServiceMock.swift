//
//  ProductsServiceMock.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 06.07.2025.
//

import XCTest
@testable import ShiftApp

final class ProductsServiceMock: ProductsServiceProtocol {
    private(set) var calls: [Calls] = []

    enum Calls {
        case fetchProducts
    }

    func fetchProducts(completionHandler: @escaping ([Product]) -> Void) {
        calls.append(.fetchProducts)
    }
}
