//
//  MediaGridViewModel.swift
//  Grid
//
//  Created by Negar Moshtaghi on 21/11/1400 AP.
//

import Foundation
import UIKit
import Alamofire

struct MediaAndInfoViewModel: Identifiable{

    var id = UUID()
    var mediaViewModel: MediaViewModel
    var mediaInfoViewModel: MediaInfoViewModel
}


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

    func getViewModelsAndHeight(index: Int, width: CGFloat) -> (MediaAndInfoViewModel, CGFloat){

        let media = medias[index]
        let viewModel = MediaViewModel(media: media)
        let infoViewModel = MediaInfoViewModel(media: media)

        let height = viewModel.calculateHeight(width: width)
        let viewModels = MediaAndInfoViewModel(mediaViewModel: viewModel,
                                               mediaInfoViewModel: infoViewModel)

        return (viewModels, height)
    }

}
