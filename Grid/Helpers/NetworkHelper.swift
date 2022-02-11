//
//  NetworkHelper.swift
//  Grid
//
//  Created by Negar Moshtaghi on 21/11/1400 AP.
//

import UIKit
import Alamofire

class NetworkHelper: NSObject {

    static let shared = NetworkHelper()
    private let imageCache = NSCache<NSString, UIImage>()
    private let apiCache = NSCache<NSString, MediaList>()
    private let apiCacheKey = NSString(string: URLs.mediaURL)

    private override init() {}


    func getMedias(completed: @escaping (Result<[Media], APError>) -> Void){

        //make URL
        guard let url = URL(string: URLs.mediaURL) else {
            completed(.failure(.invalidURL))
            return
        }

        //check for cache
        if let mediaList = apiCache.object(forKey: apiCacheKey) {
            completed(.success(mediaList.list))
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in

            if error != nil {
                completed(.failure(.invalidRequest))
                return
            }

            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode([Media].self, from: data)
                self.apiCache.setObject(MediaList(list: decodedResponse), forKey: self.apiCacheKey)
                completed(.success(decodedResponse))
            } catch {
                completed(.failure(.invalidData))
            }
        }

        task.resume()

    }

    func downloadImage(from urlString: String, width: String, height: String, completed: @escaping (UIImage?) -> Void) {

        let cacheKey = NSString(string: urlString)

        if let image = imageCache.object(forKey: cacheKey) {
            completed(image)
            return
        }

        guard var urlComponent = URLComponents(string: urlString) else {
            completed(nil)
            return
        }

        urlComponent.queryItems = [
            URLQueryItem(name: "w", value: width),
            URLQueryItem(name: "h", value: height),
            URLQueryItem(name: "m", value: "crop")
        ]

        let request = URLRequest(url: urlComponent.url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }

            self.imageCache.setObject(image, forKey: cacheKey)
            completed(image)
        }

        task.resume()
    }

    func clearCache(){
        apiCache.removeAllObjects()
        imageCache.removeAllObjects()
    }
}
