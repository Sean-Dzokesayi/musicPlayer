//
//  SearchResultImage.swift
//  MusicPlayer
//
//  Created by Sean Dzokesayi on 13/08/2022.
//

import SwiftUI

struct SearchResultImage: View {
    
    var imageURL: String

    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)){
            phase in
            
            switch phase {
            case .empty:
                Rectangle()
                    .frame(minWidth: 70, idealWidth: 70, maxWidth: 70, minHeight: 70, idealHeight: 70, maxHeight: 70, alignment: .center)
            case .success(let image):
                image.resizable()
                    .scaledToFill()
                    .cornerRadius(5.0)
                    .frame(minWidth: 70, idealWidth: 70, maxWidth: 70, minHeight: 70, idealHeight: 70, maxHeight: 70, alignment: .center)
            case .failure:
                Rectangle()
                    .frame(minWidth: 70, idealWidth: 70, maxWidth: 70, minHeight: 70, idealHeight: 70, maxHeight: 70, alignment: .center)
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

struct SearchResultImage_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultImage(imageURL: "https://images.genius.com/f3f77222e1b615e0a10354ea6282ff22.1000x1000x1.png")
    }
}
