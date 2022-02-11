//
//  MediaViewModel.swift
//  Grid
//
//  Created by Negar Moshtaghi on 22/11/1400 AP.
//

import Foundation
import UIKit
import SwiftUI

final class MediaViewModel: ObservableObject, Identifiable{

    @Published var image: UIImage = UIImage()

    var id = UUID()
    var media: Media
    var sourceImageWidth: CGFloat = 0
    var sourceImageHeight: CGFloat = 0

    required init(media: Media) {
        self.media = media
        self.sourceImageWidth = CGFloat(media.width)
        self.sourceImageHeight = CGFloat(media.height)
    }

    func getImageURL(width: Int, height: Int) -> URL?{

        let imageURL = media.thumbnailURL
        let stringWidth = "\(width)"
        let stringHeight = "\(height)"

        return URLs.getDownloadPath(urlString: imageURL, width: stringWidth, height: stringHeight)

    }

    func calculateMBSize() -> String{
        return media.size.getMegaByteFromByteValue()
    }

    func calculateHeight(width: CGFloat) -> CGFloat{
        let imageRatio = sourceImageHeight / sourceImageWidth

        return imageRatio * width
    }

}
