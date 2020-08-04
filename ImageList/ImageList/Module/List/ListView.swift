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
    var fetchingMore: Bool
    var viewModel: ListViewModel?

    // MARK: - Init

    override init(frame: CGRect) {
        tableView = UITableView()
        imageTableViewCellId = "photoCell"
        fetchingMore = false

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
        guard let viewModel = viewModel else { return 0 }
        let count: Int = (viewModel.images.count > 0) ? viewModel.images.count : 5

        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }

        if let cell = tableView.dequeueReusableCell(withIdentifier: imageTableViewCellId) as? ImageTableViewCell {

            // Update CentralImageView or use the placeholder before request is finished
            // Indexpath.row + 1 because first id is 1
            cell.centralImageView.image = viewModel.images[indexPath.row + 1] ?? UIImage.Default.photoPlaceholder!

            // Certify that array when dequeuing will not be out of index
            if viewModel.infosDidSet {
                cell.titleLabel.text = viewModel.imageInfos[indexPath.row].title
            } else {
                cell.titleLabel.text = "Title unknown"
            }

            return cell
        }

        return UITableViewCell()
    }

    // MARK: - Navigation

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }

        let info = viewModel.imageInfos[indexPath.row]

        viewModel.navigationDelegate?.goToDetail(fromImage: info)
    }

}

    // MARK: - Delegate

extension ListView: ListViewModelDelegate {

    /// Reload Table View on the main Thread
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

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

    // MARK: - Infinite scroll

extension ListView {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        // Calculated automatically, considered all images
        let contentHeight = scrollView.contentSize.height

        // If the scroll action was greater than the content - device size
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                fetchMoreImages()
            }
        }
    }

    func fetchMoreImages() {
        // Prevent calling several times
        fetchingMore = true
        viewModel?.getMoreImages({
            self.fetchingMore = false
        })
    }
}

