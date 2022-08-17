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
        
        NavigationView {
            VStack{
                
                SearchView(songModel: songModel)
                    
            
            }
      
        }
      
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView(songModel: SongModel())
    }
}
