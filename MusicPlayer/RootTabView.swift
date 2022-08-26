//
//  ContentView.swift
//  MusicPlayer
//
//  Created by Sean Dzokesayi on 12/08/2022.
//

import SwiftUI

struct RootTabView: View {
    
    @State var songModel = SongModel()
    
    var body: some View {
            TabView{
                SearchView(songModel: songModel)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    
            }
        .background(Color(uiColor: songModel.nowPlayingSong.color)
)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView(songModel: SongModel() )
    }
}


