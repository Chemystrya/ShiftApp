//
//  SceneDelegate.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 01.07.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        let userService = UserService()
        let service: AuthServiceProtocol = AuthService(userService: userService)
        let viewController = if service.isUserAuthorized() {
            HomeAssembly.assemble()
        } else {
            RegistrationAssembly.assemble()
        }

        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
}

