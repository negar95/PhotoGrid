//
//  Media.swift
//  Grid
//
//  Created by Negar Moshtaghi on 21/11/1400 AP.
//

import Foundation
import UIKit

struct Media: Identifiable, Codable{

    
    var size,
        width,
        height: Int?
    
    var id,
        thumbnailURL,
        downloadURL: String?

    enum CodingKeys: String, CodingKey {
        case id,
             size

        case thumbnailURL = "thumbnail_url"
        case downloadURL = "download_url"
        case width = "resx"
        case height = "resy"

    }


//    "filename": "tanjir-ahmed-chowdhury-FCfu2MtA4Pw-unsplash.jpg",
}

class MediaList: Codable{
    var list: [Media]

    init(list: [Media]) {
        self.list = list
    }
}
