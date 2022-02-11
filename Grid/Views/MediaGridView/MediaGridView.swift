//
//  MediaGridView.swift
//  Grid
//
//  Created by Negar Moshtaghi on 21/11/1400 AP.
//

import SwiftUI

struct MediaGridView: View {

    @StateObject private var viewModel = MediaGridViewModel()


    var body: some View {
        ZStack{
            GeometryReader{ geometry in
                NavigationView{
                    ZStack(alignment: .top){
                        ScrollView(.vertical, showsIndicators: true) {
                            ForEach(Array(stride(from: 0, to: viewModel.medias.count, by: 3)), id: \.self) { index in
                                getMediaViews(index: index, width: geometry.size.width)
                            }
                        }
                        .onAppear {
                            viewModel.getMedias()
                        }
                    }
                    .navigationTitle("Grid")
                }
                .alert(item: $viewModel.alertItem){ item in
                    item.getAlert()
                }

//                Picker("", selection: <#T##Binding<_>#>)
            }
        }
    }


    func getWidth(){

    }

    func getMediaViews(index: Int, width: CGFloat) -> some View{

        var height: CGFloat = 0

        let mediaWidth = width / 3

        var mediaViewModelArray: [MediaViewModel] = []

        let first = viewModel.medias[index]
        let firstVM = MediaViewModel(media: first)
        mediaViewModelArray.append(firstVM)
        height = max( height , firstVM.calculateHeight(width: mediaWidth))


        if viewModel.medias.indices.contains(index + 1){
            let second = viewModel.medias[index + 1]
            let secondVM = MediaViewModel(media: second)
            mediaViewModelArray.append(secondVM)
           height = max( height , secondVM.calculateHeight(width: mediaWidth))
        }

        if viewModel.medias.indices.contains(index + 2){
            let third = viewModel.medias[index + 2]
            let thirdVM = MediaViewModel(media: third)
            mediaViewModelArray.append(thirdVM)
            height = max( height , thirdVM.calculateHeight(width: mediaWidth))
        }

        return HStack{
            ForEach(mediaViewModelArray){ vm in
                MediaView(viewModel: vm)
                    .frame(width: mediaWidth,
                           height: vm.calculateHeight(width: mediaWidth),
                           alignment: .center)
                    .onTapGesture {
                        
                    }
            }
        }
        .frame(height: CGFloat(height))

    }
}

struct MediaGridView_Previews: PreviewProvider {
    static var previews: some View {
        MediaGridView()
    }
}
