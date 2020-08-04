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

    weak var delegate: ListViewModelDelegate?
    var infosDidSet: Bool
    // When imageInfos is set, reload tableview
    var imageInfos: [ImageInfo] {
        didSet {
            // After imageInfos was set, request the images
            getMoreImages()
            self.infosDidSet = true
        }
    }
    // Dictionary to assure that correct image is to its correct id
    var images: [Int: UIImage] {
        didSet {
            delegate?.reloadTableView()
        }
    }
    var services: ImageServices

    // MARK: - Init

    init(delegate: ListViewModelDelegate) {
        self.delegate = delegate
        imageInfos = []
        images = [:]
        infosDidSet = false
        // Should make as dependency but to be fast, it was done this way
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
    /// If some images where alread loaded, then grab always a +20 interval
    /// Completion: set scroll flag back to false
    func getMoreImages(_ completion: @escaping () -> Void = { } )  {

        let range = (images.count)...(images.count + 20)

        // Fetch images containing in range
        for id in range {
            let url = URL(string: imageInfos[id].thumbnailUrl!)!

            // Id from info
            let id = imageInfos[id].id

            fetchSingleImage(at: url) { (image) in
                self.images[id] = image

                // If last photo was requested, set scroll flag back to false
                if id == range.max() {
                    completion()
                }
            }
        }
    }

     /// Fetches one image
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
