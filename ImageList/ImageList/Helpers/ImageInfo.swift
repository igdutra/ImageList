//
//  ImageInfo.swift
//  ImageList
//
//  Created by Ivo Dutra on 04/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import Foundation

struct ImageInfo: Codable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String?

    // Obs: CodingKeys won't be needed
}

