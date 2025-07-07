//
//  BottomSheetViewController.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 05.07.2025.
//

import UIKit

final class BottomSheetViewController: UIViewController {
    private let viewModel: BottomSheetViewModelProtocol

    init(viewModel: BottomSheetViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .purple
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configure()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(welcomeLabel)

        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    private func configure() {
        let username = viewModel.getUsername() ?? Localizable.Home.user
        welcomeLabel.text = Localizable.Home.welcome + username + Localizable.Home.exclamation
    }
}
