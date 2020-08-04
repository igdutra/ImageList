//
//  ListView.swift
//  ImageList
//
//  Created by Ivo Dutra on 04/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

class ListView: UIView {

    // MARK: - Properties

    var tableView: UITableView
    var imageTableViewCellId: String

    var viewModel: ListViewModel?

    // MARK: - Init

    override init(frame: CGRect) {
        tableView = UITableView()
        imageTableViewCellId = "photoCell"

        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - Table View

extension ListView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let viewModel = viewModel else { return 0 }
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }

        if let cell = tableView.dequeueReusableCell(withIdentifier: imageTableViewCellId) as? ImageTableViewCell {
            // Update CentralImageView or use the placeholder before request is finished
//            cell.centralImageView.image = viewModel.images[indexPath.row] ?? UIImage.Default.photoPlaceholder!
            cell.centralImageView.image = UIImage.Default.photoPlaceholder!

            // Add title according to the day
//            let day = viewModel.days[indexPath.row]
//            cell.titleLabel.text = viewModel.photoInfos[day]?.title ?? "Title unknown"
             cell.titleLabel.text = "Title unknown"

            return cell
        }

        return UITableViewCell()
    }

}

    // MARK: - Delegate

//extension ListView: PhotoViewModelDelegate {
//
//    /// Reload Table View on the main Thread
//    func reloadTableView() {
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
//}

    // MARK: - View Codable

extension ListView: ViewCodable {

    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: imageTableViewCellId)
    }

    func setupHierarchy() {
        self.addSubviews(tableView)
    }

    func setupConstraints() {

        tableView.setConstraints { (view) in
            view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
    }

    func render() { }

    // MARK: - View Codable Helpers

}

