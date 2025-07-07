//
//  ProductsRequest.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 04.07.2025.
//

import Foundation

struct ProductsRequest: Request {
    typealias ResponseType = [Product]

    var url: URL? {
        URL(string: "\(Constants.baseUrlString)/products")
    }
}
