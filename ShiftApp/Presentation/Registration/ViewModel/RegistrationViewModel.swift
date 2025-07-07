//
//  RegistrationViewModel.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 01.07.2025.
//

protocol RegistrationViewModelProtocol {
    func usernameTextFieldDidChange(to text: String, onCheckIsValidAction: (Bool) -> Void)
    func surnameTextFieldDidChange(to text: String, onCheckIsValidAction: (Bool) -> Void)
    func passwordTextFieldDidChange(
        to text: String,
        passwordContainsEightCharAction: (Bool) -> Void,
        passwordContainsCapitalLettersAction: (Bool) -> Void,
        passwordContainsSmallLettersAction: (Bool) -> Void,
        passwordContainsOneDigitAction: (Bool) -> Void
    ) 
    func confirmPasswordTextFieldDidChange(to text: String, onCheckIsValidAction: (Bool) -> Void)
    func checkButtonAvailability(onIsValidAction: (Bool) -> Void)
    func saveUsername(username: String)
    func openHomeScreen()
}

final class RegistrationViewModel {
    private let router: RegistrationRouterProtocol
    private let userService: UserServiceProtocol

    private var username: String = ""
    private var surname: String = ""
    private var password: String = ""
    private var confirmPassword: String = ""

    private var isUsernameValid: Bool {
        username.count >= 2 && username.allSatisfy { $0.isLetter }
    }

    private var isSurnameValid: Bool {
        surname.count >= 2 && surname.allSatisfy { $0.isLetter }
    }

    private var isPasswordValid: Bool {
        passwordContainsEightChar(password: password) &&
        passwordContainsCapitalLetters(password: password) &&
        passwordContainsSmallLetters(password: password) &&
        passwordContainsOneDigit(password: password)
    }

    private var isPasswordConfirmValid: Bool {
        password == confirmPassword
    }

    init(
        router: RegistrationRouterProtocol,
        userService: UserServiceProtocol
    ) {
        self.router = router
        self.userService = userService
    }
}

// MARK: - RegistrationViewModelProtocol
extension RegistrationViewModel: RegistrationViewModelProtocol {
    func usernameTextFieldDidChange(to text: String, onCheckIsValidAction: (Bool) -> Void) {
        username = text

        onCheckIsValidAction(isUsernameValid)
    }

    func surnameTextFieldDidChange(to text: String, onCheckIsValidAction: (Bool) -> Void) {
        surname = text

        onCheckIsValidAction(isSurnameValid)
    }

    func passwordTextFieldDidChange(
        to text: String,
        passwordContainsEightCharAction: (Bool) -> Void,
        passwordContainsCapitalLettersAction: (Bool) -> Void,
        passwordContainsSmallLettersAction: (Bool) -> Void,
        passwordContainsOneDigitAction: (Bool) -> Void
    ) {
        password = text

        passwordContainsEightCharAction(passwordContainsEightChar(password: password))
        passwordContainsCapitalLettersAction(passwordContainsCapitalLetters(password: password))
        passwordContainsSmallLettersAction(passwordContainsSmallLetters(password: password))
        passwordContainsOneDigitAction(passwordContainsOneDigit(password: password))
    }

    func confirmPasswordTextFieldDidChange(to text: String, onCheckIsValidAction: (Bool) -> Void) {
        confirmPassword = text

        onCheckIsValidAction(isPasswordConfirmValid)
    }

    func checkButtonAvailability(onIsValidAction: (Bool) -> Void) {
        let isEnabled = isUsernameValid && isSurnameValid && isPasswordValid && isPasswordConfirmValid

        onIsValidAction(isEnabled)
    }

    func saveUsername(username: String) {
        userService.saveUsername(username: username)
    }

    func openHomeScreen() {
        router.openHomeScreen()
    }
}

// MARK: - Private Methods
extension RegistrationViewModel {
    private func passwordContainsEightChar(password: String) -> Bool {
        password.count >= 8
    }

    private func passwordContainsCapitalLetters(password: String) -> Bool {
        password.rangeOfCharacter(from: .uppercaseLetters) != nil
    }

    private func passwordContainsSmallLetters(password: String) -> Bool {
        password.rangeOfCharacter(from: .lowercaseLetters) != nil
    }

    private func passwordContainsOneDigit(password: String) -> Bool {
        password.rangeOfCharacter(from: .decimalDigits) != nil
    }
}
