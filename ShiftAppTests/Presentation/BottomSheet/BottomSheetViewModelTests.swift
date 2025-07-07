//
//  BottomSheetViewModelTests.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 06.07.2025.
//

import XCTest
@testable import ShiftApp

final class BottomSheetViewModelTests: XCTestCase {
    private lazy var sut = BottomSheetViewModel(userService: userService)

    private let userService = UserServiceMock()

    // MARK: - BottomSheetViewModelProtocol
    
    func testGetUsername() {
        // Act
        _ = sut.getUsername()

        //Assert
        XCTAssertEqual(userService.calls, [.getUsername])
    }
}
