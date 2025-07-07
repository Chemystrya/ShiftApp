//
//  PasswordTextField.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 02.07.2025.
//
import UIKit

final class PasswordTextField: UITextField {
    private lazy var buttonEye: UIButton = {
        let button = UIButton()
        let eyeImage = UIImage(systemName: "eye")
        let closeEyeImage = UIImage(systemName: "eye.slash")
        button.setImage(closeEyeImage, for: .normal)
        button.setImage(eyeImage, for: .selected)
        button.addAction(
            UIAction { [weak self] _ in
                button.isSelected.toggle()
                self?.isSecureTextEntry.toggle()
            }, for: .touchUpInside
        )
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    init(type: UIKeyboardType) {
        super.init(frame: .zero)

        configure()
        keyboardType = type
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        isSecureTextEntry = true
        font = UIFont.preferredFont(forTextStyle: .footnote)
        rightView = buttonEye
        rightViewMode = .always
        autocapitalizationType = .none
        tintColor = .purple
        translatesAutoresizingMaskIntoConstraints = false
    }
}

