//
//  RegistrationAssembly.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 02.07.2025.
//

import UIKit

enum RegistrationAssembly {
    static func assemble() -> UIViewController {
        let router = RegistrationRouter()
        let userService = UserService()
        let viewModel = RegistrationViewModel(router: router, userService: userService)
        let viewController = RegistrationViewController(viewModel: viewModel)
        router.transitionHandler = viewController

        return viewController
    }
}

