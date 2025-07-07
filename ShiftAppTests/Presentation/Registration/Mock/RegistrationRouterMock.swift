//
//  RegistrationRouterMock.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 06.07.2025.
//

import XCTest
@testable import ShiftApp

final class RegistrationRouterMock: RegistrationRouterProtocol {
    private(set) var calls: [Calls] = []

    enum Calls {
        case openHomeScreen
    }

    func openHomeScreen() {
        calls.append(.openHomeScreen)
    }
}
