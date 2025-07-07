//
//  UIViewController+TransitionHandler.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 02.07.2025.
//

import UIKit

extension UIViewController: TransitionHandler {
    func replaceTopviewController(with viewController: UIViewController, animated: Bool) {
        guard var viewControllers = navigationController?.viewControllers else { return }
        viewController.hidesBottomBarWhenPushed = true
        if !viewControllers.isEmpty {
            viewControllers.removeLast()
        }
        viewControllers.append(viewController)
        navigationController?.setViewControllers(viewControllers, animated: animated)
    }

    func presentModalView(viewController: UIViewController, animated: Bool) {
        viewController.modalPresentationStyle = .pageSheet
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }

        present(viewController, animated: animated) {

        }
    }
}
