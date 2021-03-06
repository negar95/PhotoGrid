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


    

    func getMediaViews(index: Int, width: CGFloat) -> some View{

        var height: CGFloat = 0

        let mediaWidth = width / 3

        var array: [MediaAndInfoViewModel] = []

        let (model, expectedHeight) = viewModel.getViewModelsAndHeight(index: index, width: mediaWidth)
        array.append(model)
        height = max(height, expectedHeight)

        if viewModel.medias.indices.contains(index + 1){
            let (model, expectedHeight) = viewModel.getViewModelsAndHeight(index: index + 1, width: mediaWidth)
            array.append(model)
            height = max(height, expectedHeight)
        }

        if viewModel.medias.indices.contains(index + 2){
            let (model, expectedHeight) = viewModel.getViewModelsAndHeight(index: index + 2, width: mediaWidth)
            array.append(model)
            height = max(height, expectedHeight)
        }

        return HStack{
            ForEach(array){ item in
                NavigationLink(destination: MediaInfoView(viewModel: item.mediaInfoViewModel)) {
                    MediaView(viewModel: item.mediaViewModel)
                        .frame(width: mediaWidth,
                               height: item.mediaViewModel.calculateHeight(width: mediaWidth),
                               alignment: .center)
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
