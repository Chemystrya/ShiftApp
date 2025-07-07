//
//  HomeViewModel.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 04.07.2025.
//


protocol HomeViewModelProtocol {
    var products: [Product] { get }

    func fetchProducts(completionHandler: @escaping () -> Void)
    func presentModalView()
}

final class HomeViewModel {
    private let productsService: ProductsServiceProtocol
    private let router: HomeRouterProtocol

    private(set) var products: [Product] = []

    init(service: ProductsServiceProtocol, router: HomeRouterProtocol) {
        self.productsService = service
        self.router = router
    }
}

// MARK: - HomeViewModelProtocol
extension HomeViewModel: HomeViewModelProtocol {
    func fetchProducts(completionHandler: @escaping () -> Void) {
        productsService.fetchProducts { [weak self] products in
            self?.products = products
            completionHandler()
        }
    }

    func presentModalView() {
        router.showModelView()
    }
}
