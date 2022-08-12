//
//  Model.swift
//  JukeBox2
//
//  Created by Sean Dzokesayi on 16/07/2022.
//


import Foundation
import AVKit


class Song: Identifiable, Codable {
    
    var id: Int
    var album: String?
    var artWorkURL: String?
    var artist: String?
    var dominantColor: String?
    var duration: Int
    var fileName: String?
    var genre: String?
    var title: String
    var rgbArray: [Double] {
        var stringArr = dominantColor?.components(separatedBy: ",")
        var doubleArr: [Double] = [Double]()
        
        for s in stringArr!{
            doubleArr.append(Double(s)!)
        }
       
        return doubleArr
    }
    
}

class SongModel: ObservableObject{
    
    @Published private var player = AVPlayer()
    @Published var songs: [Song]
    @Published var nowPlaying: Int = 0
    @Published var isPlaying: Bool = false
    
    
    init(){
        self.songs = DataService.getSongs()
        self.setupPlayer()
    }
    
    
    var isSongSetup: Bool = false
    
    var numSongs: Int {
        self.songs.count
    }
    
    var nowPlayingID: Int {
        self.nowPlaying
    }
    
    var nowPlayingSong: Song {
        self.songs[nowPlayingID]
    }
    
    func setupPlayer(){
        
        player.pause()
        
        guard let url = URL(string: "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3") else {
            self.isSongSetup = false
            return
            
        }
        
        let playerItem = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem: playerItem)
        //self.player.rate = 1.0;
        self.isSongSetup = true
        
        if(isPlaying) { player.play() }
    }
    
    func playSong(){
        if isSongSetup && !isPlaying{
            player.play()
            isPlaying = true
            return
        }
        setupPlayer()
        
    }
    
    func pauseSong(){
        if isSongSetup && isPlaying{
            player.pause()
            isPlaying = false
            return
        }
        setupPlayer()
    }
    
    func nextSong(){
        
        if (nowPlaying <= numSongs) {
             nowPlaying += 1
        }else{
            nowPlaying = 0
        }
        setupPlayer()
    }
    
    func previousSong(){
        if (nowPlaying >= 0) {
             nowPlaying -= 1
        }else{
            nowPlaying = numSongs - 1
        }
        setupPlayer()
    }
    
    
}
