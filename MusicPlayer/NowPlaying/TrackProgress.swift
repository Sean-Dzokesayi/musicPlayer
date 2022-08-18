//
//  TrackProgress.swift
//  MusicPlayer
//
//  Created by Sean Dzokesayi on 13/08/2022.
//

import SwiftUI

struct TrackProgress: View {
    
    @ObservedObject var songModel: SongModel
    //@Binding var trackProgress: Double
    
    var songDuration: Int {
        songModel.nowPlayingSong.duration
    }
    
    
    var body: some View {
        VStack{
            Slider(
                value: $songModel.currentPlayerTime,
                    in: 0...Double(songDuration)
                )
            .foregroundColor(.gray)
            HStack{
                Text("\(SongModel.formatTime(seconds:  Int(songModel.currentPlayerTime)))")
                Spacer()
                Text("\(SongModel.formatTime(seconds: songDuration))")
            }
        }
    }
}

struct TrackProgress_Previews: PreviewProvider {
    static var previews: some View {
        TrackProgress(songModel: SongModel())
    }
}
