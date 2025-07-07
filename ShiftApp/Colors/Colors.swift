//
//  Colors.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 01.07.2025.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = scanner.string.startIndex

        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff

        self.init(
            red: CGFloat(red) / 0xff,
            green: CGFloat(green) / 0xff,
            blue: CGFloat(blue) / 0xff,
            alpha: 1
        )
    }
}

extension UIColor {
    static let magnolia = UIColor(hex: "0xF8F1FF")    // светло-фиолетовый
    static let amethyst = UIColor(hex: "0x985ACE")    // фиолетовый
    static let flamingo = UIColor(hex: "0xF34C3F")    // красный
}
