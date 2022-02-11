//
//  MediaInfoViewModel.swift
//  Grid
//
//  Created by Negar Moshtaghi on 22/11/1400 AP.
//

import Foundation
import UIKit

final class MediaInfoViewModel: ObservableObject{

    var media: Media
    var createdAt: Date

    required init(media: Media) {
        self.media = media
        self.createdAt = media.createdAt.toDate()
    }

    func getImageURL(width: Int, height: Int) -> URL?{

        let imageURL = media.thumbnailURL
        let stringWidth = "\(width)"
        let stringHeight = "\(height)"

        return URLs.getDownloadPath(urlString: imageURL, width: stringWidth, height: stringHeight)

    }
}
