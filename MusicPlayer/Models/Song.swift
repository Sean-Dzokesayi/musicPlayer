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
        let stringArr = dominantColor?.components(separatedBy: ",")
        var doubleArr: [Double] = [Double]()
        
        for s in stringArr!{
            doubleArr.append(Double(s)! / 255)
        }
        
        return doubleArr
    }
    

    var color: UIColor{
        let sp = CGColorSpace(name:CGColorSpace.genericRGBLinear)!
        let comps : [CGFloat] = [rgbArray[0], rgbArray[1], rgbArray[2], 1]

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
    var nowPlaying: Int = 0
    @Published var isPlaying: Bool = false
    @Published var currentPlayerTime: Double = 0
    
    // Search page vars
    @Published var searchText: String = ""
    @Published var searchResults: [Song] = [Song]()
    //@Published var selectedSongId: Int!
    
    var isSongSetup: Bool = false
    var timeObserverToken: Any?
    var timeStamp: Float64 = 0

    
    init(){
        self.songs = DataService.getSongs()
        self.setupPlayer()
        addTimeObserver()
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
    
    
    
    
    func searchSong(){
        searchResults.removeAll()
        for song in songs{
            if song.title.lowercased().contains(searchText.lowercased()){
                searchResults.append(song)
            }
        }
    }
    
    func selectedSong(selectedSongId id: Int){
        nowPlaying = id
        setupPlayer()
    }
    
    func addTimeObserver(){
        self.player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.player.currentItem?.status == .readyToPlay {
                
                // Check if user is seeking audio
                if self.currentPlayerTime != self.timeStamp {
                    let seekTime = CMTimeMakeWithSeconds(self.currentPlayerTime,
                                                         preferredTimescale: 1000)
                    
                    self.player.seek(to: seekTime,
                                     toleranceBefore: .zero,
                                     toleranceAfter: .zero)
                }
                
                
                let time : Float64 = CMTimeGetSeconds(self.player.currentTime());
                self.timeStamp = time
                self.currentPlayerTime = Double(time)
                print(SongModel.formatTime(seconds: Int(self.currentPlayerTime)))
            }
        }
    }
    
    static func formatTime(seconds: Int) -> String{
        let time = seconds;
        let minutes = Int(time / 60);
        
        
        let seconds = time - minutes * 60;
        if (seconds < 10) {
            return "\(minutes):0\(seconds)"
        }
        return "\(minutes):\(seconds)"
    }

    
    var numSongs: Int {
        self.songs.count
    }
    

    
    var nowPlayingID: Int {
        self.nowPlaying
    }
    
    var nowPlayingSong: Song {
      //  print("-----------------\nThere are \(numSongs) songs \nNowplaying \(nowPlayingID)")
        return self.songs[nowPlayingID]
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
        addTimeObserver()
        
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
