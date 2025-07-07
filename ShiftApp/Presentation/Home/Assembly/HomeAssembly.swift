//
//  HomeAssembly.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 04.07.2025.
//

import UIKit

enum HomeAssembly {
    static func assemble() -> UIViewController {
        let httpClient = HttpClient()
        let service = ProductsService(httpClient: httpClient)
        let router = HomeRouter()
        let viewModel = HomeViewModel(service: service, router: router)
        let viewController = HomeViewController(viewModel: viewModel)
        router.transitionHandler = viewController

        return viewController
    }
}
