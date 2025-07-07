//
//  HomeTableViewCell.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 04.07.2025.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    static let reuseIdentifier = "HomeTableViewCell"

    // MARK: - UIElements
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let starStackView: StarsStackView = {
        let stackView = StarsStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - SetupUI
    private func setupUI() {
        stackView.addArrangedSubviews(
            [
                titleLabel,
                priceLabel,
                starStackView,
            ]
        )

        contentView.addSubviews([productImageView, stackView])

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 4),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            productImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -4),
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.heightAnchor.constraint(equalToConstant: 80),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
        ])
    }

    // MARK: - Configure
    func configure(with product: Product) {
        if let imageUrl = product.image,
           !imageUrl.isEmpty {
            let imageUrl = "\(imageUrl)"
            self.productImageView.setImage(
                stringUrl: imageUrl,
                placeholder: UIImage(systemName: "photo")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
            )
        } else {
            self.productImageView.image = UIImage(systemName: "photo")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        }
        
        titleLabel.text = product.title
        starStackView.configure(with: product.rating.rate)
        priceLabel.text = "\(product.price)$"
    }
}

