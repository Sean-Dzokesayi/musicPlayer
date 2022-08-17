//
//  NowPlayingView.swift
//  MusicPlayer
//
//  Created by Sean Dzokesayi on 13/08/2022.
//

import SwiftUI

struct NowPlayingView: View {
    
    @ObservedObject var songModel: SongModel
    
    var body: some View {
        ZStack {
            Color(uiColor: songModel.nowPlayingSong.color)
                .ignoresSafeArea()
            VStack{
                LargeImage(imageURL: songModel.nowPlayingSong.artWorkURL != "" ? songModel.nowPlayingSong.artWorkURL! : "")
                
                NowPlayingSongInfo(nowPlaying: songModel.nowPlayingSong)
                
                TrackProgress(songModel: songModel )
                //,trackProgress: $songModel.currentPlayerTime
                
                
                Spacer()
                
                // Track Controls
                TrackControls(songModel: songModel, isSongPlaying: $songModel.isPlaying)
                
                
                                
            }
            .ignoresSafeArea()
            .padding(.top, 150.0)
            .padding()
        }
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView(songModel: SongModel())
    }
}
