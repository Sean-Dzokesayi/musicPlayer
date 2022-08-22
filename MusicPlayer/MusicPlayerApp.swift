//
//  MusicPlayerApp.swift
//  MusicPlayer
//
//  Created by Sean Dzokesayi on 12/08/2022.
//

import SwiftUI
import Firebase


@main
struct MusicPlayerApp: App {
    
    init(){
        FirebaseApp.configure()
        
    }
    
    var body: some Scene {
        WindowGroup {
            RootTabView()
        }
    }
}
