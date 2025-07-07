//
//  ProductsService.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 04.07.2025.
//

import Foundation

protocol ProductsServiceProtocol {
    func fetchProducts(completionHandler: @escaping ([Product]) -> Void)
}

final class ProductsService: ProductsServiceProtocol {
    private let httpClient: HttpClient

    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }

    func fetchProducts(completionHandler: @escaping ([Product]) -> Void) {
        let request = ProductsRequest()
        httpClient.send(request) { result in
            switch result {
            case .success(let products):
                completionHandler(products)
            case .failure(let error):
                print(error)
            }
        }
    }
}
