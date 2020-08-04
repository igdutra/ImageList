//
//  DetailView.swift
//  ImageList
//
//  Created by Ivo Dutra on 04/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

class DetailView: UIView {

    // MARK: - Properties

    var imageView: UIImageView

    var viewModel: DetailViewModel? {
        didSet {
            configure()
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        imageView = UIImageView()

        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - View Codable

extension DetailView: ViewCodable {

    func configure() {
        guard let viewModel = viewModel else { return }
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.Default.photoPlaceholder
    }

    func setupHierarchy() {
        self.addSubviews(imageView)
    }

    func setupConstraints() {
        imageView.setConstraints { (view) in
            view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        }
    }

    func render() { }

}
