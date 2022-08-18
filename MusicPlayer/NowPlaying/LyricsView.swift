//
//  LyricsView.swift
//  MusicPlayer
//
//  Created by Sean Dzokesayi on 17/08/2022.
//

import SwiftUI

struct LyricsView: View {

    @ObservedObject var songModel: SongModel

    var body: some View {
        VStack{
            
            Text(songModel.nowPlayingSong.title)
            Text(songModel.nowPlayingSong.artist ?? "")
            
            ScrollView{
                Text(songModel.nowPlayingSong.lyrics ?? "No lyrics")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()

            }
            
            TrackProgress(songModel: songModel)
                .padding()
            
            TrackControls(songModel: songModel, isSongPlaying: $songModel.isPlaying)
        }
//        .navigationTitle("Lyrics")
        .background(Color(uiColor: songModel.nowPlayingSong.color))
    }
}

struct LyricsView_Previews: PreviewProvider {
    static var previews: some View {
        LyricsView(songModel: SongModel())
    }
}
