//
//  largeImage_np.swift
//  MusicPlayer
//
//  Created by Sean Dzokesayi on 12/08/2022.
//

import SwiftUI

struct LargeImage: View {
    
    var imageURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)){
            phase in
            
            switch phase {
            case .empty:
                Rectangle()
                    .frame(width: 350, height: 350, alignment: .center)
            case .success(let image):
                image.resizable()
                    .scaledToFill()
                    .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                    .frame(width: 350, height: 350, alignment: .center)
            case .failure:
                Rectangle()
                    .frame(width: 350, height: 350, alignment: .center)
            @unknown default:
                // Since the AsyncImagePhase enum isn't frozen,
                // we need to add this currently unused fallback
                // to handle any new cases that might be added
                // in the future:
                EmptyView()
                
            }
        }
    }
}

struct largeImage_np_Previews: PreviewProvider {
    static var previews: some View {
        LargeImage(imageURL: "https://images.genius.com/f3f77222e1b615e0a10354ea6282ff22.1000x1000x1.png")
    }
}
