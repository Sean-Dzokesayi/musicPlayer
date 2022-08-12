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
        
        let red = songModel.nowPlayingSong.rgbArray[0]
        let green = songModel.nowPlayingSong.rgbArray[1]
        let blue = songModel.nowPlayingSong.rgbArray[2]
        
        ZStack {
            (Color(red: blue / 255, green: green / 255, blue: blue / 255))
            VStack{
                
                LargeImage(imageURL: songModel.nowPlayingSong.artWorkURL != "" ? songModel.nowPlayingSong.artWorkURL! : "")
                
                NowPlayingSongInfo(nowPlaying: songModel.nowPlayingSong)
                
                
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
        RootTabView(songModel: SongModel())
    }
}
