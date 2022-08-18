//
//  NowPlayingView.swift
//  MusicPlayer
//
//  Created by Sean Dzokesayi on 13/08/2022.
//

import SwiftUI

struct NowPlayingView: View {
    
    @ObservedObject var songModel: SongModel
    @State var isLyricsDisplayed: Bool = false
    
    var body: some View {
        ZStack {
            Color(uiColor: songModel.nowPlayingSong.color)
                .ignoresSafeArea()
            VStack{
                Spacer()
                LargeImage(imageURL: songModel.nowPlayingSong.artWorkURL != "" ? songModel.nowPlayingSong.artWorkURL! : "")
                    
                Spacer()
                NowPlayingSongInfo(nowPlaying: songModel.nowPlayingSong)
                
                TrackProgress(songModel: songModel )
                    .padding()
                //,trackProgress: $songModel.currentPlayerTime
                
                
                
                // Track Controls
                TrackControls(songModel: songModel, isSongPlaying: $songModel.isPlaying)
                
                
                VStack {
                    
                    HStack{
                        Text("Lyrics")
                        Spacer()
                        
                        NavigationLink {
                            LyricsView(songModel: songModel)
                        } label: {
                            HStack{
                                Text("More")
                                Image(systemName: "arrow.up.backward.and.arrow.down.forward")
                            }
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            .cornerRadius(20)
                        }
                        
                    }
                    
                }
                .padding()
                
            }
            .ignoresSafeArea()
        }.padding(.top, 50).ignoresSafeArea()
            
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView(songModel: SongModel())
    }
}
