//
//  DataService.swift
//  JukeBox2
//
//  Created by Sean Dzokesayi on 16/07/2022.
//

import Foundation


class DataService {
    
    static func getSongs() -> [Song] {
        
        // Get the path of the data
        let pathString = Bundle.main.path(forResource: "Songs", ofType: "json")
        
        // Return empty array if pathString is nil
        guard pathString != nil else{
            return [Song]()
        }
        
        // Create URL object
        let url = URL(fileURLWithPath: pathString!)
        
        
        do {
            // Create the data object
            let data = try Data(contentsOf: url)
            
            // Create decoder
            let decoder = JSONDecoder()
            
            
            
            do {
                // Store decoded json data in a new variable
                let songData: [Song] = try decoder.decode([Song].self, from: data)
                var newData: [Song] = [Song]()
                var idCounter = 0
                for song in songData{
                    song.fileName = song.fileName.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
                    if song.artWorkURL != ""{
                        song.id = idCounter
                        newData.append(song)
                        idCounter += 1
                        
                        
                    }
                }
                
                
                return newData
            }
            catch {
                // Error decoding the data
                print(error)
                
            }
            
            
        }
        catch{
            // Error creating the data object
            print(error)
        }
        
        
        
        
        return [Song]()
    }
    
}
