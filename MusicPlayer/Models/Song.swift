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
    var fileName: String
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
    
    var color: UIColor{
        let sp = CGColorSpace(name:CGColorSpace.genericRGBLinear)!
        let comps : [CGFloat] = [rgbArray[0] / 255, rgbArray[1] / 255, rgbArray[2] / 255, 1]
        let c = CGColor(colorSpace: sp, components: comps)!
        let sp2 = CGColorSpace(name:CGColorSpace.sRGB)!
        let c2 = c.converted(to: sp2, intent: .relativeColorimetric, options: nil)!
        let color = UIColor(cgColor: c2)
        return color

    }
    
    
}

class SongModel: ObservableObject{
    
    static let rootURL = "http://192.168.0.24:8000/"
    @Published var player = AVPlayer()
    @Published var songs: [Song]
    @Published var nowPlaying: Int = 0
    @Published var isPlaying: Bool = false
    var isSongSetup: Bool = false
    var timeObserverToken: Any?
    
    init(){
        self.songs = DataService.getSongs()
        self.setupPlayer()
    }

    func addPeriodicTimeObserver() {
        // Notify every half second
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)

        timeObserverToken = player.addPeriodicTimeObserver(forInterval: time,
                                                          queue: .main) {
            [weak self] time in
            // update player transport UI
            print("\(time)")
        }
    }

    func removePeriodicTimeObserver() {
        if let timeObserverToken = timeObserverToken {
            player.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }
    
    
    
    
    
    
    var numSongs: Int {
        self.songs.count
    }
    

    
    var nowPlayingID: Int {
        self.nowPlaying
    }
    
    var nowPlayingSong: Song {
        self.songs[nowPlayingID]
    }
    
    var songURL: String {
        SongModel.rootURL + nowPlayingSong.fileName
    }
    
    func setupPlayer(){
        
        player.pause()
        player.audiovisualBackgroundPlaybackPolicy = .continuesIfPossible
        guard let url = URL(string: songURL) else {
            self.isSongSetup = false
            return
            
        }
       print("\n\n\n-----------------\n\(songURL)\n-----------------\n\n\n")
        
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
        if (nowPlaying > 0) {
             nowPlaying -= 1
        }else{
            nowPlaying = numSongs - 1
        }
        setupPlayer()
    }
    
    
}
