//
//  ImageServices.swift
//  ImageList
//
//  Created by Ivo Dutra on 04/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

/// Services Layer for ImageInfo
class ImageServices {

    var baseURL = URL(string: "https://jsonplaceholder.typicode.com/photos")!

    // MARK: - Fetch Info

    func fetchImageInfo(completion: @escaping ([ImageInfo]?) -> Void) {

        let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in

            // Handle Errors
            if let error = error {
                print(error)
                return
            }

            // Handle Response
            // 200-299 status codes are Successful responses
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print(error as Any)
                return
            }

            let jsonDecoder = JSONDecoder()

            if let data = data, let imageInfo = try? jsonDecoder.decode([ImageInfo].self, from: data) {
                completion(imageInfo)
            } else {
                print("No data returned")
                completion(nil)
            }

        }

        task.resume()
    }

    // MARK: - Fetch Image

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
