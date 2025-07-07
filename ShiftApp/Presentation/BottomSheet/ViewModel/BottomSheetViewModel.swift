//
//  BottomSheetViewModel.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 05.07.2025.
//

protocol BottomSheetViewModelProtocol {
    func getUsername() -> String?
}

final class BottomSheetViewModel {
    private let userService: UserServiceProtocol

    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
}

// MARK: - BottomSheetViewModelProtocol
extension BottomSheetViewModel: BottomSheetViewModelProtocol {
    func getUsername() -> String? {
        userService.getUsername()
    }
}
