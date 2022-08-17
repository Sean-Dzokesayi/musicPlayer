//
//  MiniPlayerView.swift
//  MusicPlayer
//
//  Created by Sean Dzokesayi on 13/08/2022.
//

import SwiftUI

struct MiniPlayerView: View {
    
    @ObservedObject var songModel: SongModel
    @Binding var isSongPlaying: Bool 
    
    var body: some View {
        ZStack{
            Color(uiColor: songModel.nowPlayingSong.color)
                HStack{
                    
                    
                    NavigationLink {
                        NowPlayingView(songModel: songModel)
                            .ignoresSafeArea()
                    } label: {
                        HStack{
                            MiniPlayerImage(imageURL: songModel.nowPlayingSong.artWorkURL!)
                            Text(songModel.nowPlayingSong.title)
                                .font(.title3)
                        }
                    }

                    Spacer()
                    
                    if isSongPlaying{
                        Button {
                            // Pause button
                            songModel.pauseSong()
                        } label: {
                            Image(systemName: "pause.fill")
                                .padding(.horizontal)
                                .font(.system(size: 25, weight: .bold))
                                

                        }
                    }else{
                        Button {
                            // Play button
                            songModel.playSong()
                        } label: {
                            Image(systemName: "play.fill")
                                .padding(.horizontal)
                                .font(.system(size: 25, weight: .bold))

                        }
                    }
                    
                }
        }.ignoresSafeArea()
        .foregroundColor(.black)
        .frame(maxHeight: 75)
        .cornerRadius(15)

    }
}

struct MiniPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MiniPlayerView(songModel: SongModel(), isSongPlaying: .constant(true))
    }
}
