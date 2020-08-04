//
//  ListViewModel.swift
//  ImageList
//
//  Created by Ivo Dutra on 04/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

/// ViewModel's Delegate is the View
protocol ListViewModelDelegate: class {
    func reloadTableView()
}

class ListViewModel {

    // MARK: - Properties

    weak var navigationDelegate: ListViewController?
    weak var delegate: ListViewModelDelegate?
    /// Used to certify that array when dequeuing will not be out of index
    var infosDidSet: Bool
    // When imageInfos is set, get the images
    var imageInfos: [ImageInfo] {
        didSet {
            // After imageInfos was set, request the images
            getMoreImages()
            self.infosDidSet = true
        }
    }
    /// Dictionary to assure that correct image is to its correct id
    var images: [Int: UIImage] {
        didSet {
            delegate?.reloadTableView()
        }
    }
    var services: ImageServices

    // MARK: - Init

    init(delegate: ListViewModelDelegate, navigation: ListViewController) {
        self.delegate = delegate
        self.navigationDelegate = navigation
        imageInfos = []
        images = [:]
        infosDidSet = false
        // Should make as dependency but for this test it was made this way
        services = ImageServices()

        // Fetch all infos
        getAllInfos()
    }

    // MARK: - Get All Infos

    func getAllInfos() {

        services.fetchImageInfo { (infos) in

            if let imageInfos = infos {
                self.imageInfos = imageInfos
                self.delegate?.reloadTableView()
            } else {
                print("could not get infos")
            }
        }

    }

    // MARK: - Get Images

    /// If no image was requested, range is 0...20
    /// If some images where alread loaded, then grab the images always inside a +20 interval
    /// Completion: set scroll flag back to false
    func getMoreImages(_ completion: @escaping () -> Void = { } )  {

        let range = (images.count)...(images.count + 20)

        // Fetch images containing in range
        for id in range {
            let url = URL(string: imageInfos[id].thumbnailUrl!)!

            // Id from info
            let id = imageInfos[id].id

            services.fetchSingleImage(at: url) { (image) in
                self.images[id] = image

                // If last photo was requested, set scroll flag back to false
                if id == range.max() {
                    completion()
                }
            }
        }
    }

    // MARK: - Navigation

    func goToDetail(fromImage info: ImageInfo) {
        navigationDelegate?.goToDetail(fromImage: info)
    }

}
