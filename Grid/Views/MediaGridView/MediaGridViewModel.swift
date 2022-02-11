//
//  MediaGridViewModel.swift
//  Grid
//
//  Created by Negar Moshtaghi on 21/11/1400 AP.
//

import Foundation
import UIKit
import Alamofire

final class MediaGridViewModel: ObservableObject{

    @Published var medias: [Media] = []
    @Published var alertItem: ErrorAlert?
//    @Published var 

    func getMedias(){
//        NetworkHelper.shared.clearCache()
        
        NetworkHelper.shared.getMedias { [self] result in
            DispatchQueue.main.async {

                switch result {
                case .success(let medias):
                    self.medias = medias

                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData

                    case .invalidURL:
                        alertItem = AlertContext.invalidURL

                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse

                    case .invalidRequest:
                        alertItem = AlertContext.invalidRequest
                    }
                }
            }
        }
    }

}
