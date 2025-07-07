//
//  HomeRouter.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 05.07.2025.
//

import UIKit

protocol HomeRouterProtocol {
    func showModelView()
}

final class HomeRouter: HomeRouterProtocol {
    weak var transitionHandler: TransitionHandler?

    func showModelView() {
        let viewController = BottomSheetAssembly.assemble()
        transitionHandler?.presentModalView(viewController: viewController, animated: true)
    }
}

