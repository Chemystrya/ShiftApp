//
//  AuthService.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 04.07.2025.
//

import Foundation

protocol AuthServiceProtocol {
    func isUserAuthorized() -> Bool
    func logout()
}

final class AuthService: AuthServiceProtocol {
    private let userService: UserServiceProtocol

    init(userService: UserServiceProtocol) {
        self.userService = userService
    }

    func isUserAuthorized() -> Bool {
        userService.getUsername() != nil
    }

    func logout() {
        userService.removeObject()
    }
}
