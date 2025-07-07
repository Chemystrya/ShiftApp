//
//  RegistrationViewController.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 01.07.2025.
//

import UIKit

final class RegistrationViewController: UIViewController {
    private let viewModel: RegistrationViewModelProtocol

    // MARK: - UIElements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let registrationLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.Registration.registration
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .purple
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let usernameView: UIView = {
        let view = UIView()
        view.backgroundColor = .magnolia
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.magnolia.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    private lazy var usernameTextField = makeTextField(
        placeholder: Localizable.Registration.username,
        leftImage: UIImage(systemName: "person.crop.square")
    )

    private let userSurnameView: UIView = {
        let view = UIView()
        view.backgroundColor = .magnolia
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.magnolia.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var userSurnameTextField = makeTextField(
        placeholder: Localizable.Registration.surname,
        leftImage: UIImage(systemName: "person.crop.square.fill")
    )

    private let dateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.Registration.dateOfBirth
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let containerDateOfBirthView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let dateOfBirthView: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.locale = NSLocale(localeIdentifier: "ru_RU") as Locale
        datePicker.tintColor = .purple
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePicker.translatesAutoresizingMaskIntoConstraints = false

        return datePicker
    }()

    private let passwordView: UIView = {
        let view = UIView()
        view.backgroundColor = .magnolia
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let passwordTextField: UITextField = {
        let textField = PasswordTextField()
        textField.placeholder = Localizable.Registration.password
        textField.font = UIFont.systemFont(ofSize: 18)

        return textField
    }()

    private let passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let passwordEightCharLabel = {
        let label = UILabel()
        label.text = Localizable.Registration.eightChar
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let capitalLettersLabel = {
        let label = UILabel()
        label.text = Localizable.Registration.capitalLetters
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let smallLettersLabel = {
        let label = UILabel()
        label.text = Localizable.Registration.smallLetters
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let oneDigitLabel = {
        let label = UILabel()
        label.text = Localizable.Registration.oneDigit
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let confirmPasswordView: UIView = {
        let view = UIView()
        view.backgroundColor = .magnolia
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let confirmPasswordTextField: UITextField = {
        let textField = PasswordTextField()
        textField.placeholder = Localizable.Registration.confirmYourPassword
        textField.font = UIFont.systemFont(ofSize: 18)

        return textField
    }()

    private let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.Registration.passwordDoesNotMatch
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = .white
        return label
    }()

    private lazy var registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Localizable.Registration.register, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.tintColor = .white
        button.backgroundColor = .purple
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(
            UIAction { [weak self] _ in
                self?.registrationTapped()
            },
            for: .touchUpInside)

        return button
    }()

    // MARK: - Life Cycle
    init(viewModel: RegistrationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        scrollView.addGestureRecognizer(tap)

        setupUI()
        registerForKeyboardNotifications()
        setupActions()
    }

    deinit {
        removeKeyBoardNotifications()
    }

    // MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews([registrationLabel, mainStackView, registrationButton])

        mainStackView.addArrangedSubviews(
            [
                usernameView,
                userSurnameView,
                containerDateOfBirthView,
                passwordView,
                passwordStackView,
                confirmPasswordView,
                confirmPasswordLabel
            ]
        )

        containerDateOfBirthView.addSubviews([dateOfBirthLabel, dateOfBirthView])

        passwordStackView.addArrangedSubviews(
            [
                passwordEightCharLabel,
                capitalLettersLabel,
                smallLettersLabel,
                oneDigitLabel
            ]
        )

        usernameView.addSubview(usernameTextField)
        userSurnameView.addSubview(userSurnameTextField)
        passwordView.addSubview(passwordTextField)
        confirmPasswordView.addSubview(confirmPasswordTextField)

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),

            registrationLabel.topAnchor.constraint(lessThanOrEqualTo: containerView.topAnchor, constant: 100),
            registrationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            registrationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),

            mainStackView.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 60),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),

            registrationButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 60),
            registrationButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            registrationButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            registrationButton.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -100),
            registrationButton.heightAnchor.constraint(equalToConstant: 54),

            usernameTextField.leadingAnchor.constraint(equalTo: usernameView.leadingAnchor, constant: 10),
            usernameTextField.trailingAnchor.constraint(equalTo: usernameView.trailingAnchor),
            usernameTextField.topAnchor.constraint(equalTo: usernameView.topAnchor),
            usernameTextField.bottomAnchor.constraint(equalTo: usernameView.bottomAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 54),

            userSurnameTextField.leadingAnchor.constraint(equalTo: userSurnameView.leadingAnchor, constant: 10),
            userSurnameTextField.trailingAnchor.constraint(equalTo: userSurnameView.trailingAnchor),
            userSurnameTextField.topAnchor.constraint(equalTo: userSurnameView.topAnchor),
            userSurnameTextField.bottomAnchor.constraint(equalTo: userSurnameView.bottomAnchor),
            userSurnameTextField.heightAnchor.constraint(equalToConstant: 54),

            dateOfBirthLabel.topAnchor.constraint(equalTo: containerDateOfBirthView.topAnchor),
            dateOfBirthLabel.leadingAnchor.constraint(equalTo: containerDateOfBirthView.leadingAnchor),
            dateOfBirthLabel.bottomAnchor.constraint(equalTo: containerDateOfBirthView.bottomAnchor),

            dateOfBirthView.topAnchor.constraint(equalTo: containerDateOfBirthView.topAnchor),
            dateOfBirthView.leadingAnchor.constraint(equalTo: dateOfBirthLabel.trailingAnchor, constant: 20),
            dateOfBirthView.trailingAnchor.constraint(equalTo: containerDateOfBirthView.trailingAnchor),
            dateOfBirthView.bottomAnchor.constraint(equalTo: containerDateOfBirthView.bottomAnchor),

            passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -10),
            passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 54),

            confirmPasswordTextField.leadingAnchor.constraint(equalTo: confirmPasswordView.leadingAnchor, constant: 10),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: confirmPasswordView.trailingAnchor, constant: -10),
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordView.topAnchor),
            confirmPasswordTextField.bottomAnchor.constraint(equalTo: confirmPasswordView.bottomAnchor),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
}

// MARK: - Private Methods
extension RegistrationViewController {
    private func makeTextField(placeholder: String, leftImage: UIImage?) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.keyboardType = .default
        textField.autocapitalizationType = .none
        textField.tintColor = .purple
        textField.translatesAutoresizingMaskIntoConstraints = false

        if let leftImage = leftImage {
            let leftContainer = UIView(frame: CGRect(x: 0, y: 0, width: 42, height: 32))
            let imageView = UIImageView(image: leftImage.withRenderingMode(.alwaysTemplate))
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .purple
            imageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)

            leftContainer.addSubview(imageView)
            textField.leftView = leftContainer
            textField.leftViewMode = .always
        }

        return textField
    }

    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else {
            return
        }

        let keyboardHeight = keyboardFrame.height
        scrollView.setContentOffset(CGPoint(x: 0, y: keyboardHeight / 2), animated: true)
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }

    private func removeKeyBoardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func registrationTapped() {
        guard let username = usernameTextField.text else { return }

        viewModel.saveUsername(username: username)
        viewModel.openHomeScreen()
    }

    private func checkButtonAvailability() {
        viewModel.checkButtonAvailability { isEnabled in
            registrationButton.isEnabled = isEnabled
        }
    }

    private func setupActions() {
        usernameTextField.addAction(
            UIAction { [weak self] _ in
                guard let self else { return }

                usernameTextFieldDidChange(usernameTextField)
            },
            for: .editingChanged
        )

        userSurnameTextField.addAction(
            UIAction { [weak self] _ in
                guard let self else { return }

                surnameTextFieldDidChange(userSurnameTextField)
            },
            for: .editingChanged
        )

        passwordTextField.addAction(
            UIAction { [weak self] _ in
                guard let self else { return }

                passwordTextFieldDidChange(passwordTextField)
            },
            for: .editingChanged
        )

        confirmPasswordTextField.addAction(
            UIAction { [weak self] _ in
                guard let self else { return }

                confirmPasswordTextFieldDidChange(confirmPasswordTextField)
            },
            for: .editingChanged
        )
    }

    private func usernameTextFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }

        viewModel.usernameTextFieldDidChange(to: text) { isValid in
            usernameView.layer.borderColor = isValid ? UIColor.purple.cgColor : UIColor.flamingo.cgColor
        }

        checkButtonAvailability()
    }

    private func surnameTextFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }

        viewModel.surnameTextFieldDidChange(to: text) { isValid in
            userSurnameView.layer.borderColor = isValid ? UIColor.purple.cgColor : UIColor.flamingo.cgColor
        }

        checkButtonAvailability()
    }

    private func passwordTextFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }

        viewModel.passwordTextFieldDidChange(
            to: text,
            passwordContainsEightCharAction: { isValid in
                passwordEightCharLabel.textColor = isValid ? .purple : .gray
            },
            passwordContainsCapitalLettersAction: { isValid in
                capitalLettersLabel.textColor = isValid ? .purple : .gray
            },
            passwordContainsSmallLettersAction: { isValid in
                smallLettersLabel.textColor = isValid ? .purple : .gray
            },
            passwordContainsOneDigitAction: { isValid in
                oneDigitLabel.textColor = isValid ? .purple : .gray
            }
        )

        checkButtonAvailability()
    }

    private func confirmPasswordTextFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }

        viewModel.confirmPasswordTextFieldDidChange(to: text) { isValid in
            confirmPasswordLabel.text = isValid
            ? Localizable.Registration.passwordMatches
            : Localizable.Registration.passwordDoesNotMatch
            confirmPasswordLabel.textColor = isValid ? .purple : .gray
        }

        checkButtonAvailability()
    }
}
