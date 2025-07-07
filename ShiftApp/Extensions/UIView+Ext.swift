//
//  UIView+Ext.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 01.07.2025.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
