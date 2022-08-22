//
//  Model.swift
//  JukeBox2
//
//  Created by Sean Dzokesayi on 16/07/2022.
//


import Foundation
import AVKit
import FirebaseDatabase
import FirebaseSharedSwift
import FirebaseStorage

extension DispatchQueue {

    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

}

class Song: Identifiable, Codable {
    
    
    init(id: Int, album: String, artWorkURL: String?, artist: String, dominantColor: String?, duration: Int, fileName: String, genre: String?, title: String, lyrics: String?) {
        self.id = id
        self.album = album
        self.artWorkURL = artWorkURL
        self.artist = artist
        self.dominantColor = dominantColor
        self.duration = duration
        self.fileName = fileName
        self.genre = genre
        self.title = title
        self.lyrics = lyrics
    }
    
    var id: Int
    var album: String
    var artWorkURL: String?
    var artist: String
    var dominantColor: String?
    var duration: Int
    var fileName: String
    var genre: String?
    var title: String
    var lyrics: String?
    var rgbArray: [Double] {
        let stringArr = dominantColor?.components(separatedBy: ",")
        var doubleArr: [Double] = [Double]()
        
        for s in stringArr!{
            if s == "null" || s == ""{
                doubleArr.append(133 / 255)
                doubleArr.append(49 / 255)
                doubleArr.append(38 / 255)
            }else{
                doubleArr.append(Double(s)! / 255)
            }
           
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
    let ref = Database.database().reference()
    
    
    static let rootURL = "https://firebasestorage.googleapis.com/v0/b/jukebox_songs/o/Music%2F01%20-%"
    static let urlEnd = "?alt=media&token=597efc5e-e63a-49af-bc02-73c8b98d1463"
    @Published var player = AVPlayer()
    
    @Published var songs: [Song] = [Song]()
    var nowPlaying: Int = 0
    @Published var isPlaying: Bool = false
    @Published var currentPlayerTime: Double = 0
    @Published var searchType: String = "Songs"
    
    // Search page vars
    @Published var searchText: String = ""
    @Published var searchResultSongs: [Song] = [Song]()
    @Published var searchResultArtists: [Song] = [Song]()
    @Published var searchResultAlbums: [Song] = [Song]()
    @Published var results: [Song] = [Song]()
    
    
    var isSongSetup: Bool = false
    var timeObserverToken: Any?
    var timeStamp: Float64 = 0

    
    init(){
        songs.append(Song(id: 0, album: "", artWorkURL: "", artist: "", dominantColor: "255,255,255", duration: 0, fileName: "", genre: "", title: "", lyrics: ""))
        getSongs()
        self.setupPlayer()
        self.addTimeObserver()
        
    }
    
    func getSongs(){
        var fetchedSongData = [Song]()
        self.ref.observeSingleEvent(of: .value){snapshot in
            for case let child as DataSnapshot in snapshot.children {
                guard let dict = child.value as? [String:Any] else {
                        print("Error")
                        return
                    }
                
                let title: String! = dict["title"] as? String
                let artist: String! = dict["artist"] as? String
                    let artWorkURL: String! = dict["artWorkURL"] as? String
                var album: String! = dict["album"] as? String
                let dominantColor: String! = dict["dominantColor"] as? String
                let duration: Int? = dict["duration"] as? Int
                    let fileName: String! = dict["fileName"] as? String
                    let genre: String! = dict["genre"] as? String
                let id: Int = dict["trackID"] as! Int
                    let lyrics: String = (dict["lyrics"] != nil) ? (dict["lyrics"] as! String) : ""
//                    let trackTotal = dict["trackTotal"] as! String
//                    let year = dict["year"] as! String
                    print("id: \(id) ... title: \(title)")
                self.songs.append(Song(id: id, album: album ?? "", artWorkURL: artWorkURL, artist: artist, dominantColor: dominantColor, duration: duration ?? 0, fileName: fileName, genre: genre, title: title, lyrics: lyrics))
                fetchedSongData.append(Song(id: id, album: album ?? "", artWorkURL: artWorkURL, artist: artist, dominantColor: dominantColor, duration: duration ?? 0, fileName: fileName, genre: genre, title: title, lyrics: lyrics))
                self.songs = fetchedSongData
                }
        }
        self.songs = fetchedSongData
        setupPlayer()
     
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
    
    func searchTypeChangeToArtists(){
        searchType = "Artists"
        updateResults()
    }
    
    func searchTypeChangeToSongs(){
        searchType = "Songs"
        updateResults()
    }
    
    func searchTypeChangeToAlbums(){
        searchType = "Albums"
        updateResults()
    }
    
    func updateResults(){
        results = [Song]()
        if(searchType == "Songs"){
            results = searchResultSongs
        }
        if(searchType == "Artists"){
            results = searchResultArtists
        }
        if(searchType == "Albums"){
            results = searchResultAlbums
        }
    }
    
    
    
    
    func searchSong(){
        
        searchResultSongs.removeAll()
        searchResultArtists.removeAll()
        searchResultAlbums.removeAll()
        for song in songs{
            if song.title.lowercased().contains(searchText.lowercased()){
                searchResultSongs.append(song)
            }
            if ((song.album.lowercased().contains(searchText.lowercased()))){
                searchResultAlbums.append(song)
            }
            if ((song.artist.lowercased().contains(searchText.lowercased()))){
                searchResultArtists.append(song)
            }
        }
        updateResults()
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
        if songs.count != 0{
            return songs[nowPlaying]
        }else{
            return Song(id: 0, album: "", artWorkURL: "", artist: "", dominantColor: "255,255,255", duration: 0, fileName: "", genre: "", title: "", lyrics: "")
        }

    }
    
    var songURL: String {
        nowPlayingSong.fileName
    }
    
    func setupPlayer(){

        player.pause()
        currentPlayerTime = 0
        
        // Create a reference to the file you want to download
        let gsReference = Storage.storage().reference(forURL: "gs://jukebox_songs/Music/\(songURL)")
print(gsReference)
        // Fetch the download URL
        gsReference.downloadURL { url, error in
          if let error = error {
            // Handle any errors
              print(error)
          } else {
            // Get the download URL for gsReference
              self.player.audiovisualBackgroundPlaybackPolicy = .continuesIfPossible
              
              print("\nURL is: \(url)\n")

              let playerItem = AVPlayerItem(url: url!)
              self.player = AVPlayer(playerItem: playerItem)
              //self.player.rate = 1.0;
              self.isSongSetup = true
              self.addTimeObserver()
                  
              if(self.isPlaying) { self.player.play() }
          }
        }
            
        
        
        
        
        
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
        print("Now playing \(nowPlaying)")
        setupPlayer()
        print("Done setting up player")
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
