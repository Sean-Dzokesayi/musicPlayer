/*
See LICENSE folder for this sample’s licensing information.

Abstract:
`NowPlayableStaticMetadata` contains static properties of a playable item that don't depend on the state of the player for their value.
*/

import Foundation
import MediaPlayer

struct NowPlayableStaticMetadata {
    
    let assetURL: URL                   // MPNowPlayingInfoPropertyAssetURL
    let mediaType: MPNowPlayingInfoMediaType
                                        // MPNowPlayingInfoPropertyMediaType
    let isLiveStream: Bool              // MPNowPlayingInfoPropertyIsLiveStream
    
    let title: String                   // MPMediaItemPropertyTitle
    let artist: String?                 // MPMediaItemPropertyArtist
    let artwork: MPMediaItemArtwork?    // MPMediaItemPropertyArtwork
    
    let albumArtist: String?            // MPMediaItemPropertyAlbumArtist
    let albumTitle: String?             // MPMediaItemPropertyAlbumTitle
    
    init(assetURL: URL, mediaType: MPNowPlayingInfoMediaType, isLiveStream: Bool, title: String, artist: String?, artwork: MPMediaItemArtwork?, albumArtist: String?, albumTitle: String?) {
        self.assetURL = assetURL
        self.mediaType = mediaType
        self.isLiveStream = isLiveStream
        self.title = title
        self.artist = artist
        self.artwork = artwork
        self.albumArtist = albumArtist
        self.albumTitle = albumTitle
    }
    
}

struct NowPlayableDynamicMetadata {
    
    let rate: Float                     // MPNowPlayingInfoPropertyPlaybackRate
    let position: Float                 // MPNowPlayingInfoPropertyElapsedPlaybackTime
    let duration: Float                 // MPMediaItemPropertyPlaybackDuration
    
    let currentLanguageOptions: [MPNowPlayingInfoLanguageOption]
                                        // MPNowPlayingInfoPropertyCurrentLanguageOptions
    let availableLanguageOptionGroups: [MPNowPlayingInfoLanguageOptionGroup]
                                        // MPNowPlayingInfoPropertyAvailableLanguageOptions
    
}
