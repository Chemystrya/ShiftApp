//
//  BottomSheetAssembly.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 05.07.2025.
//

import UIKit

enum BottomSheetAssembly {
    static func assemble() -> UIViewController {
        let userService = UserService()
        let viewModel = BottomSheetViewModel(userService: userService)
        let viewController = BottomSheetViewController(viewModel: viewModel)

        return viewController
    }
}
