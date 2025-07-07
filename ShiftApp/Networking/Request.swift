//
//  Request.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 04.07.2025.
//

import Foundation

protocol Request {
    associatedtype ResponseType: Decodable

    var url: URL? { get }
}
