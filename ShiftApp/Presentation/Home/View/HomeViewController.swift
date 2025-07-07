//
//  HomeViewController.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 02.07.2025.
//

import UIKit

final class HomeViewController: UIViewController {
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let viewModel: HomeViewModelProtocol

    private lazy var welcomeButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localizable.Home.greetings, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 14
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction { [weak self] _ in
            self?.welcomeButtonTapped()
        }, for: .touchUpInside)

        return button
    }()

    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Localizable.Home.products
        
        setupTableView()
        setupActivityIndicator()
        loadProductsFromServer()
    }
}

// MARK: - Private Methods
extension HomeViewController {
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)
        view.addSubview(welcomeButton)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            welcomeButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
            welcomeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            welcomeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            welcomeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            welcomeButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }

    private func setupActivityIndicator() {
        activityIndicator.color = .purple
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func loadProductsFromServer() {
        activityIndicator.startAnimating()
        tableView.isHidden = true

        viewModel.fetchProducts {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }

                self.activityIndicator.stopAnimating()
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }

    private func welcomeButtonTapped() {
        viewModel.presentModalView()
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "HomeTableViewCell",
                for: indexPath
            ) as? HomeTableViewCell
        else {
            return UITableViewCell()
        }

        let product = viewModel.products[indexPath.row]
        cell.configure(with: product)

        return cell
    }
}
