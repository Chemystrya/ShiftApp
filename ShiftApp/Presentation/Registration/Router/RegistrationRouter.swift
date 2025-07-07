//
//  RegistrationRouter.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 02.07.2025.
//

import UIKit

protocol RegistrationRouterProtocol {
    func openHomeScreen()
}

final class RegistrationRouter: RegistrationRouterProtocol {
    weak var transitionHandler: TransitionHandler?

    func openHomeScreen() {
        let viewController = HomeAssembly.assemble()
        transitionHandler?.replaceTopviewController(with: viewController, animated: true)
    }
}
