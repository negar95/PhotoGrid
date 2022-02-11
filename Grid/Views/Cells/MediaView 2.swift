//
//  MediaView.swift
//  Grid
//
//  Created by Negar Moshtaghi on 21/11/1400 AP.
//

import SwiftUI


struct MediaLocation{
    var width: Int = 0
    var height: Int = 0
    var yPosition: Int = 0
    var xPosition: Int = 0
}

struct MediaView: View {

    @StateObject var viewModel: MediaViewModel

    var body: some View {

        ZStack(alignment: .bottomTrailing){

            GeometryReader{ geometry in

            Image(uiImage: viewModel.image)
                .resizable()
                .cornerRadius(5)
                .onAppear {
                    let width = Int(geometry.size.width)
                    let height = Int(geometry.size.height)

                    viewModel.loadImage(width: width,
                                        height: height)
                }
            }
            Text(viewModel.calculateMBSize() + " MB")
                .font(.system(size: 12))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(2)
                .background(Color.white.opacity(0.2))
        }

    }
}

