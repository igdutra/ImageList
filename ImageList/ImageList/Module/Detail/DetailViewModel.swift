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
    var greaterImage: UIImage? {
        didSet {
            delegate?.loadImage()
        }
    }

    // MARK: - Init

    init(info: ImageInfo, delegate: DetailViewModelDelegate) {
        self.info = info
        self.delegate = delegate

        let url = URL(string: info.url)!

        // Grab image
        fetchSingleImage(at: url) { (image) in
            self.greaterImage = image
        }
    }

    // MARK: - fetch Image

    // Obs: this function is beeing written twice. Could be better.

     /// Fetches the greaterImage
    func fetchSingleImage(at url: URL, _ completion: @escaping (UIImage) -> Void) {

        // Request the image
        let imageTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data, let image = UIImage(data: data) else { return }

            // The image should be saved at the correct position from the images array
            completion(image)
        }

        imageTask.resume()
    }

}
