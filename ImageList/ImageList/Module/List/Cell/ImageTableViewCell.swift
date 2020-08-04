//
//  ImageTableViewCell.swift
//  ImageList
//
//  Created by Ivo Dutra on 04/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    // MARK: - Properties
    var centralImageView: UIImageView
    var titleLabel: UILabel

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        centralImageView = UIImageView()
        titleLabel = UILabel()

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - View Codable

extension ImageTableViewCell: ViewCodable {

    func configure() {
        configureCentralImage()
        configureLabel()
    }

    func setupHierarchy() {
        self.addSubviews(centralImageView, titleLabel)
    }

    func setupConstraints() {

        centralImageView.setConstraints { (view) in
            // Pin View to borders and topConstraint to titleLabel
            view.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        }

        titleLabel.setConstraints { (view) in
            // Pin View to the center horizontally and at the top.
            // Bottom constraint already set at centralImage
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        }
    }

    func render() { }

    func updateView() { }

    // MARK: - View Codable Helpers

    func configureCentralImage() {
        // This enables the view to be pinned to the borders
        centralImageView.contentMode = .scaleAspectFit
        // Add placeholder photo
        centralImageView.image = UIImage.Default.photoPlaceholder
    }

    func configureLabel() {
        titleLabel.text = ""
        titleLabel.numberOfLines = 0
    }
}
