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
        self.sourceImageWidth = CGFloat(media.width ?? 0)
        self.sourceImageHeight = CGFloat(media.height ?? 0)
    }

    func loadImage(width: Int, height: Int){

        let stringWidth = "\(width)"
        let stringHeight = "\(height)"

        let imageURL = media.thumbnailURL ?? ""

        NetworkHelper.shared.downloadImage(from: imageURL,
                                           width: stringWidth,
                                           height: stringHeight)
        { fetchedImage in
            guard let uiImage = fetchedImage else { return }
            DispatchQueue.main.async {
                self.image = uiImage
            
            }
        }
    }

    func calculateMBSize() -> String{
        return media.size?.getMegaByteFromByteValue() ?? ""
    }

    func calculateHeight(width: CGFloat) -> CGFloat{
        let imageRatio = sourceImageHeight / sourceImageWidth

        return imageRatio * width
    }

}
