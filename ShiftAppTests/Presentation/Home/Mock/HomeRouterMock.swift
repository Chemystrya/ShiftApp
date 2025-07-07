//
//  HomeRouterMock.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 06.07.2025.
//

import XCTest
@testable import ShiftApp

final class HomeRouterMock: HomeRouterProtocol {
    private(set) var calls: [Calls] = []

    enum Calls {
        case showModelView
    }

    func showModelView() {
        calls.append(.showModelView)
    }
}
