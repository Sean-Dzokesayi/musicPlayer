//
//  SearchView.swift
//  MusicPlayer
//
//  Created by Sean Dzokesayi on 13/08/2022.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var songModel: SongModel
    
    var body: some View {
        
        VStack{
            TextField("Search for title", text: $songModel.searchText)
                .padding()
                .onSubmit {
                    songModel.searchSong()
                }
                .font(.title3)
    
            
            ScrollView{
                ForEach(songModel.searchResults){ song in
                    HStack{
                        Button {
                            songModel.selectedSong(selectedSongId: song.id)
                        } label: {
                            Group{
                                HStack{
                                    SearchResultImage(imageURL: song.artWorkURL ?? "")
                                    
                                    VStack(alignment: .leading, spacing: 5){
                                        Text("\(song.title)")
                                            .font(.title2)
                                            .fontWeight(Font.Weight.medium)
                                        if song.artist != nil{
                                            Text(song.artist!)
                                                .font(.title3)
                                        }
                                        
                                    }.foregroundColor(.black)
                                        
                                }
                            }
                        }
                        
                        
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                        }
                        
                    }
                    
                    
                }
                .background(Color(uiColor: songModel.nowPlayingSong.color)).ignoresSafeArea()
            }
            
            
            
            
            
            Spacer()
            MiniPlayerView(songModel: songModel, isSongPlaying: $songModel.isPlaying)
                .padding([.leading, .bottom, .trailing], 1.0)
            
            
        }
            .padding()
            .padding(.top, 30.0)
            .padding(.bottom, 0)
            .ignoresSafeArea()
        
        
            .background(Color(uiColor: songModel.nowPlayingSong.color))
        
        
    }
    
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(songModel: SongModel())
    }
}