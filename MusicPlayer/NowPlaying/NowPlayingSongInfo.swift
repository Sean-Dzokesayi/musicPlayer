//
//  NowPlayingSongInfo.swift
//  MusicPlayer
//
//  Created by Sean Dzokesayi on 12/08/2022.
//

import SwiftUI

struct NowPlayingSongInfo: View {
    
    var nowPlaying: Song
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                // Song name
                Text(nowPlaying.title)
                
                if nowPlaying.artist != nil {
                    Text(nowPlaying.artist!)
                }
                
            }
            .padding()
            Spacer()
            Image(systemName: "ellipsis.circle")
                .padding(.trailing)
            
        }
        .padding(.bottom)
    }
}

struct NowPlayingSongInfo_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingSongInfo(nowPlaying: SongModel().songs[0])
    }
}
