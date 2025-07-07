//
//  StarsStackView.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 04.07.2025.
//

import UIKit

final class StarsStackView: UIView {
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(starStackView)

        NSLayoutConstraint.activate([
            starStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            starStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            starStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            starStackView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }

    func configure(with stars: Double) {
        starStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for index in 0..<5 {
            let starImageView = UIImageView()
            starImageView.contentMode = .scaleAspectFit
            let image = index < Int(stars) ? "star.fill" : "star"
            let color: UIColor = index < Int(stars) ? .amethyst : .lightGray
            starImageView.image = UIImage(systemName: image)?.withTintColor(color, renderingMode: .alwaysOriginal)
            starImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
            starImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true

            starStackView.addArrangedSubview(starImageView)
        }
    }
}


