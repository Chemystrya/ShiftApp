//
//  UserServiceMock.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 06.07.2025.
//

import XCTest
@testable import ShiftApp

final class UserServiceMock: UserServiceProtocol {

    // Stubs
    var stubbedUsername = "username"

    private(set) var calls: [Calls] = []

    enum Calls {
        case saveUsername
        case getUsername
        case removeObject
    }

    func saveUsername(username: String) {
        calls.append(.saveUsername)
    }

    func getUsername() -> String? {
        calls.append(.getUsername)
        return stubbedUsername
    }

    func removeObject() {
        calls.append(.removeObject)
    }
}
