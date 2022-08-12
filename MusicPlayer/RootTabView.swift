//
//  ContentView.swift
//  MusicPlayer
//
//  Created by Sean Dzokesayi on 12/08/2022.
//

import SwiftUI

struct RootTabView: View {
    
    @ObservedObject var songModel = SongModel()
    var body: some View {
    
        
        ZStack{
            Color(uiColor: songModel.nowPlayingSong.color)
            VStack{
                
                LargeImage(imageURL: songModel.nowPlayingSong.artWorkURL != "" ? songModel.nowPlayingSong.artWorkURL! : "")
                
                NowPlayingSongInfo(nowPlaying: songModel.nowPlayingSong)
                
                
                
                VStack{
                    // MARK: Song Progress (range slider)
                    
                   // Slider(value: $test)
                        
                    // MARK: Song Progress (durations)
                    
                    HStack{
                        
                        Text("0:00")
                        Spacer()
                        Text(String(songModel.nowPlayingSong.duration))
                        
                    }
                    .padding(.top)
                    
                }
                
                
                
                
                
                
                // Track Controls
                TrackControls(songModel: songModel, isSongPlaying: $songModel.isPlaying)
                
                
                
                
                Spacer()
            }
            .padding(.top, 150.0)

            
        }.ignoresSafeArea()
        
        
        
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView(songModel: SongModel() )
    }
}
