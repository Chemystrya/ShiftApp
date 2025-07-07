//
//  RegistrationViewModelTests.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 06.07.2025.
//

import XCTest
@testable import ShiftApp

final class RegistrationViewModelTests: XCTestCase  {
    private lazy var sut = RegistrationViewModel(router: router, userService: userService)

    private let router = RegistrationRouterMock()
    private let userService = UserServiceMock()

    // MARK: - RegistrationViewModelProtocol

    func testUsernameTextFieldDidChange_valid() {
        // Arrange
        var isValid: Bool = false

        // Act
        sut.usernameTextFieldDidChange(to: "username") { result in
            isValid = result
        }

        //Assert
        XCTAssertEqual(isValid, true)
    }

    func testUsernameTextFieldDidChange_notValid() {
        // Arrange
        var isValid: Bool = true

        // Act
        sut.usernameTextFieldDidChange(to: "u1") { result in
            isValid = result
        }

        //Assert
        XCTAssertEqual(isValid, false)
    }

    func testSurnameTextFieldDidChange_valid() {
        // Arrange
        var  isValid: Bool = false

        // Act
        sut.surnameTextFieldDidChange(to: "surname") { result in
            isValid = result
        }

        //Assert
        XCTAssertEqual(isValid, true)
    }

    func testSurnameTextFieldDidChange_notValid() {
        // Arrange
        var isValid: Bool = true

        // Act
        sut.surnameTextFieldDidChange(to: "s1") { result in
            isValid = result
        }

        //Assert
        XCTAssertEqual(isValid, false)
    }

    func testPasswordTextFieldDidChange_valid() {
        // Arrange
        var isContainsEightCharValid: Bool = false
        var isContainsCapitalLettersValid: Bool = false
        var isContainsSmallLettersValid: Bool = false
        var isContainsOneDigitValid: Bool = false

        // Act
        sut.passwordTextFieldDidChange(
            to: "Q1qqqqqq",
            passwordContainsEightCharAction: { result in
                isContainsEightCharValid = result
            },
            passwordContainsCapitalLettersAction: { result in
                isContainsCapitalLettersValid = result
            },
            passwordContainsSmallLettersAction: { result in
                isContainsSmallLettersValid = result
            },
            passwordContainsOneDigitAction: { result in
                isContainsOneDigitValid = result
            }
        )

        //Assert
        XCTAssertEqual(isContainsEightCharValid, true)
        XCTAssertEqual(isContainsCapitalLettersValid, true)
        XCTAssertEqual(isContainsSmallLettersValid, true)
        XCTAssertEqual(isContainsOneDigitValid, true)
    }

    func testPasswordTextFieldDidChange_notValid() {
        // Arrange
        var isContainsEightCharValid: Bool = true
        var isContainsCapitalLettersValid: Bool = true
        var isContainsSmallLettersValid: Bool = true
        var isContainsOneDigitValid: Bool = true

        // Act
        sut.passwordTextFieldDidChange(
            to: "",
            passwordContainsEightCharAction: { result in
                isContainsEightCharValid = result
            },
            passwordContainsCapitalLettersAction: { result in
                isContainsCapitalLettersValid = result
            },
            passwordContainsSmallLettersAction: { result in
                isContainsSmallLettersValid = result
            },
            passwordContainsOneDigitAction: { result in
                isContainsOneDigitValid = result
            }
        )

        //Assert
        XCTAssertEqual(isContainsEightCharValid, false)
        XCTAssertEqual(isContainsCapitalLettersValid, false)
        XCTAssertEqual(isContainsSmallLettersValid, false)
        XCTAssertEqual(isContainsOneDigitValid, false)
    }

    func testConfirmPasswordTextFieldDidChange_valid() {
        // Arrange
        var isValid: Bool = false
        sut.passwordTextFieldDidChange(
            to: "Q1qqqqqq",
            passwordContainsEightCharAction: { _ in },
            passwordContainsCapitalLettersAction: { _ in },
            passwordContainsSmallLettersAction: { _ in },
            passwordContainsOneDigitAction: { _ in }
        )

        // Act
        sut.confirmPasswordTextFieldDidChange(to: "Q1qqqqqq") { result in
            isValid = result
        }

        //Assert
        XCTAssertEqual(isValid, true)
    }

    func testConfirmPasswordTextFieldDidChange_notValid() {
        // Arrange
        var isValid: Bool = true
        sut.passwordTextFieldDidChange(
            to: "Q1qqqqqq",
            passwordContainsEightCharAction: { _ in },
            passwordContainsCapitalLettersAction: { _ in },
            passwordContainsSmallLettersAction: { _ in },
            passwordContainsOneDigitAction: { _ in }
        )

        // Act
        sut.confirmPasswordTextFieldDidChange(to: "Q1qqqfff") { result in
            isValid = result
        }

        //Assert
        XCTAssertEqual(isValid, false)
    }

    func testCheckButtonAvailability_valid() {
        // Arrange
        var isValid: Bool = false
        sut.usernameTextFieldDidChange(to: "username", onCheckIsValidAction: { _ in })
        sut.surnameTextFieldDidChange(to: "surname", onCheckIsValidAction: { _ in })
        sut.passwordTextFieldDidChange(
            to: "Q1qqqqqq",
            passwordContainsEightCharAction: { _ in },
            passwordContainsCapitalLettersAction: { _ in },
            passwordContainsSmallLettersAction: { _ in },
            passwordContainsOneDigitAction: { _ in }
        )
        sut.confirmPasswordTextFieldDidChange(to: "Q1qqqqqq", onCheckIsValidAction: { _ in })

        // Act
        sut.checkButtonAvailability { result in
            isValid = result
        }

        //Assert
        XCTAssertEqual(isValid, true)
    }

    func testCheckButtonAvailability_notValid() {
        // Arrange
        var isValid: Bool = true
        sut.usernameTextFieldDidChange(to: "username", onCheckIsValidAction: { _ in })
        sut.surnameTextFieldDidChange(to: "surname", onCheckIsValidAction: { _ in })
        sut.passwordTextFieldDidChange(
            to: "Q1qqqqqq",
            passwordContainsEightCharAction: { _ in },
            passwordContainsCapitalLettersAction: { _ in },
            passwordContainsSmallLettersAction: { _ in },
            passwordContainsOneDigitAction: { _ in }
        )
        sut.confirmPasswordTextFieldDidChange(to: "Q1ffffff", onCheckIsValidAction: { _ in })

        // Act
        sut.checkButtonAvailability { result in
            isValid = result
        }

        //Assert
        XCTAssertEqual(isValid, false)
    }

    func testSaveUsername() {
        // Act
        sut.saveUsername(username: "username")

        //Assert
        XCTAssertEqual(userService.calls, [.saveUsername])
    }

    func testOpenHomeScreen() {
        // Act
        sut.openHomeScreen()

        //Assert
        XCTAssertEqual(router.calls, [.openHomeScreen])
    }
}
