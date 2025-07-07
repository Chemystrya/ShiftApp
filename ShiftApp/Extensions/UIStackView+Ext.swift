//
//  UIStackView+Ext.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 01.07.2025.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
