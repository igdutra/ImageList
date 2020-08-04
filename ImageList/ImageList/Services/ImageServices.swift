//
//  ImageServices.swift
//  ImageList
//
//  Created by Ivo Dutra on 04/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import Foundation

/// Services Layer for ImageInfo
class ImageServices {

    var baseURL = URL(string: "https://jsonplaceholder.typicode.com/photos")!

    // MARK: - Fetch

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

}
