//
//  URLs.swift
//  Grid
//
//  Created by Negar Moshtaghi on 21/11/1400 AP.
//

import Foundation

struct URLs{
    static let key = "djlCbGusTJamg_ca4axEVw"
    static let baseURL = "https://api1.kiliaro.com"
    static let mediaURL = "\(baseURL)/shared/\(key)/media"

    static func getDownloadPath(urlString: String, width: String, height: String) -> URL?{
        guard var urlComponent = URLComponents(string:  urlString) else {
            return nil
        }

        urlComponent.queryItems = [
            URLQueryItem(name: "w", value: width),
            URLQueryItem(name: "h", value: height),
            URLQueryItem(name: "m", value: "crop")
        ]

        return urlComponent.url!
    }
    
}
