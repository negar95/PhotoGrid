//
//  NetworkError.swift
//  Grid
//
//  Created by Negar Moshtaghi on 21/11/1400 AP.
//

import Foundation
import Alamofire

struct NetworkError: Error {
    let initialError: AFError
    let backendError: BackendError?
}

struct BackendError: Codable, Error {

    var httpCode: Int
    var error: String
    var context: String

    enum CodingKeys: String, CodingKey {
        case error, context
        case httpCode = "http_code"
    }

}
