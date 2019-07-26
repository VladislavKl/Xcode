//
//  SoundManager.swift
//  MatchCards
//
//  Created by Klyuev Vladislav on 01/04/2019.
//  Copyright © 2019 Klyuev Vladislav. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static var audioPlayer: AVAudioPlayer?
    
    enum SoundEffect {
        case flip
        case shuffle
        case match
        case nomatch
    }
    
    static func playSound(_ effect: SoundEffect) {
        
        var soundFilename = ""
        
        //Determine which sound affect we want to play and set the appropriate filename
        switch effect {
            
        case .flip:
            soundFilename = "cardflip"
            
        case .shuffle:
            soundFilename = "shuffle"
            
        case .match:
            soundFilename = "dingcorrect"
            
        case .nomatch:
            soundFilename = "dingwrong"
            
        }
        
        // Get the path to the sound file inside the bundle
        let bundlepath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        
        guard bundlepath != nil else {
            print("Couldn't find sound file \(soundFilename) in the bundle")
            return
        }
        
        //Create a URL object from this string path
        let soundURL = URL(fileURLWithPath: bundlepath!)
        
        do{
            // Create audioPlayer object
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        }
        catch {
            //Couldn't create audioPlayer object, log the error
            print("Couldn't create audioPlayer object for sound filee \(soundFilename)")
        }
    }
    
}
