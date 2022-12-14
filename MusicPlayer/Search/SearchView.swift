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
        
        NavigationStack {
            VStack{
                TextField("Search for title", text: $songModel.searchText)
                    .padding()
                    .onSubmit {
                        songModel.searchSong()
                    }
                    .font(.title3)
        
                HStack(spacing: 15){
                    Button {
                        songModel.searchTypeChangeToSongs()
                    } label: {
                        Text("Songs")
                    }
                    
                    Button {
                        songModel.searchTypeChangeToArtists()
                    } label: {
                        Text("Artists")
                    }
                    
                    Button {
                        songModel.searchTypeChangeToAlbums()
                    } label: {
                        Text("Albums")
                    }
                    Button {
                        songModel.searchTypeChangeToAlbums()
                    } label: {
                        Text("Genre")
                    }

                }
                
                
                ResultList(songModel: songModel)

                 MiniPlayerView(songModel: songModel, isSongPlaying: $songModel.isPlaying)
        
                
                
            }
                .padding()
                .padding(.top, 30.0)
                .padding(.bottom, 0)
            .background(Color(uiColor: songModel.nowPlayingSong.color))
        }
//            .navigationTitle("Search")
        
        
    }
    
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(songModel: SongModel())
    }
}

struct ResultList: View {
    
    @ObservedObject var songModel: SongModel
    
    var body: some View {
        
        ScrollView{
            ForEach(songModel.results){ song in
                HStack{
                    Button {
                        songModel.selectedSong(selectedSong: song.id)
                    } label: {
                        Group{
                            HStack{
                                SearchResultImage(imageURL: song.artWorkURL ?? "")
                                
                                VStack(alignment: .leading, spacing: 5){
                                    Text("\(song.title)")
                                        .font(.title2)
                                        .fontWeight(Font.Weight.medium)
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
    }
}
