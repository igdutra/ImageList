//
//  DetailViewModel.swift
//  ImageList
//
//  Created by Ivo Dutra on 04/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

/// ViewModel's Delegate is the View
protocol DetailViewModelDelegate: class {
    func loadImage()
}

class DetailViewModel {

    // MARK: - Properties

    weak var delegate: DetailViewModelDelegate?
    var info: ImageInfo
    var service: ImageServices
    var greaterImage: UIImage? {
        didSet {
            delegate?.loadImage()
        }
    }

    // MARK: - Init

    init(info: ImageInfo, delegate: DetailViewModelDelegate) {
        self.info = info
        self.delegate = delegate
        self.service = ImageServices()

        let url = URL(string: info.url)!

        // Grab image
        service.fetchSingleImage(at: url) { (image) in
            self.greaterImage = image
        }
    }
}
