//
//  TransitionHandler.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 02.07.2025.
//

import UIKit

protocol TransitionHandler: AnyObject {
    func replaceTopviewController(with viewController: UIViewController, animated: Bool)
    func presentModalView(viewController: UIViewController, animated: Bool)
}

