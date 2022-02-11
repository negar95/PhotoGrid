//
//  MediaView.swift
//  Grid
//
//  Created by Negar Moshtaghi on 21/11/1400 AP.
//

import SwiftUI
import URLImage

struct MediaLocation{
    var width: Int = 0
    var height: Int = 0
    var yPosition: Int = 0
    var xPosition: Int = 0
}

struct MediaView: View {
    
    @StateObject var viewModel: MediaViewModel
    
    var body: some View {
        
        GeometryReader{ geometry in
            
            ZStack(alignment: .bottomTrailing){
                
                let width = Int(geometry.size.width)
                let height = Int(geometry.size.height)
                
                if let url = viewModel.getImageURL(width: width, height: height){
                    URLImage(url: url,
                             content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(5)
                    })
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
}

