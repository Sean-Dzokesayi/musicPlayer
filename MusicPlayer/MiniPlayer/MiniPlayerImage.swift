//
//  MiniPlayerImage.swift
//  MusicPlayer
//
//  Created by Sean Dzokesayi on 13/08/2022.
//

import SwiftUI

struct MiniPlayerImage: View {
    
    var imageURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)){
            phase in
            
            switch phase {
            case .empty:
                Rectangle()
                    .frame(minWidth: 60, idealWidth: 60, maxWidth: 60, minHeight: 60, idealHeight: 60, maxHeight: 60, alignment: .center)
            case .success(let image):
                image.resizable()
                    .scaledToFill()
                    .cornerRadius(5.0)
                    .frame(minWidth: 60, idealWidth: 60, maxWidth: 60, minHeight: 60, idealHeight: 60, maxHeight: 60, alignment: .center)
            case .failure:
                Rectangle()
                    .frame(minWidth: 60, idealWidth: 60, maxWidth: 60, minHeight: 60, idealHeight: 60, maxHeight: 60, alignment: .center)
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

struct MiniPlayerImage_Previews: PreviewProvider {
    static var previews: some View {
        MiniPlayerImage(imageURL: SongModel().songs[0].artWorkURL!)
    }
}
