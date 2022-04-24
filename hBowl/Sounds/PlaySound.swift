//
//  PlaySound.swift
//  hBowl
//
//  Created by Adam Reed on 4/21/22.
//


import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?


func playSound(sound: String, type: String) {
    
    let audioSession = AVAudioSession.sharedInstance()
    
    do {
        try audioSession.setCategory(.ambient, mode: .default, options: [.mixWithOthers])
    } catch {
        print("Failed to set adio session category")
    }
    
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Could not find or play the sound file")
        }
    }
    
}
