//
//  String+Ext.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 01.07.2025.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
