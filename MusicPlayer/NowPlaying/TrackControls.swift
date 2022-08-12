//
//  TrackControls.swift
//  MusicPlayer
//
//  Created by Sean Dzokesayi on 12/08/2022.
//

import SwiftUI


struct TrackControls: View {
    
    @ObservedObject var songModel: SongModel
    @Binding var isSongPlaying: Bool 
    
    var body: some View {
        HStack{
            Spacer()
            
            Button {
                songModel.previousSong()
            } label: {
                Image(systemName: "backward.fill")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.gray)
            }
            
            
            Spacer()
            
            if isSongPlaying{
                Button {
                    // Pause button
                    songModel.pauseSong()
                } label: {
                    Image(systemName: "pause.fill")
                        .padding(.horizontal)
                        .font(.system(size: 35, weight: .bold))
                    
                }
            }else{
                Button {
                    // Play button
                    songModel.playSong()
                } label: {
                    Image(systemName: "play.fill")
                        .padding(.horizontal)
                        .font(.system(size: 35, weight: .bold))
                    
                }
            }
            
            
            
            
            Spacer()
            
            Button {
                // Next button
                songModel.nextSong()
                
            } label: {
                Image(systemName: "forward.fill")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.gray)
            }
            
            
            Spacer()
        }
        .foregroundColor(.gray)

    }
}


struct TrackControls_Previews: PreviewProvider {
    static var previews: some View {
        TrackControls(songModel: SongModel(), isSongPlaying: .constant(false))
    }
}
