//
//  UserService.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 05.07.2025.
//

import Foundation

protocol UserServiceProtocol {
    func saveUsername(username: String)
    func getUsername() -> String?
    func removeObject()
}

final class UserService: UserServiceProtocol {
    private let userDefaults = UserDefaults.standard
    private let usernameKey = "savedUsername"

    func saveUsername(username: String) {
        userDefaults.set(username, forKey: usernameKey)
    }

    func getUsername() -> String? {
        userDefaults.string(forKey: usernameKey)
    }

    func removeObject() {
        userDefaults.removeObject(forKey: usernameKey)
    }
}
