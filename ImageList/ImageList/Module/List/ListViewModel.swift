//
//  ListViewModel.swift
//  ImageList
//
//  Created by Ivo Dutra on 04/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import Foundation

/// ViewModel's Delegate is the View
protocol ListViewModelDelegate: class {
    func reloadTableView()
}

class ListViewModel {

    // MARK: - Properties

    weak var delegate: ListViewModelDelegate?
    var imageInfos: [ImageInfo]
    var services: ImageServices

    // MARK: - Init

    init(delegate: ListViewModelDelegate) {
        imageInfos = []
        // Should make as dependency but to be fast, it was done this way
        services = ImageServices()

        // Fetch all infos
        getImages()
    }

    // MARK: - Get Images

    func getImages() {

        services.fetchImageInfo { (infos) in

            if let imageInfos = infos {
                self.imageInfos = imageInfos
                print(imageInfos)
            } else {
                print("could not get infos")
            }
        }

    }

}
