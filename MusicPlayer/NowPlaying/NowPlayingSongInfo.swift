//
//  NowPlayingSongInfo.swift
//  MusicPlayer
//
//  Created by Sean Dzokesayi on 12/08/2022.
//

import SwiftUI

struct FixedClipped: ViewModifier {
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            content.hidden().layoutPriority(1)
            content.fixedSize(horizontal: true, vertical: false)
        }
        .clipped()
    }
}

extension View {
    func fixedClipped() -> some View {
        self.modifier(FixedClipped())
    }
}


struct NowPlayingSongInfo: View {
    
    var nowPlaying: Song
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                // Song name
                Text(nowPlaying.title)
                    .font(.title2)
                    .fixedClipped()
                Text(nowPlaying.artist)
                    .font(.title3)
                    .fixedClipped()
              
                
            }
            .padding()
            Spacer()
            Image(systemName: "ellipsis.circle")
                .padding(.trailing)
            
        }
        .padding(.bottom)
        .navigationTitle("Now Playing")
    }
}

struct NowPlayingSongInfo_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingSongInfo(nowPlaying: SongModel().songs[0])
    }
}
