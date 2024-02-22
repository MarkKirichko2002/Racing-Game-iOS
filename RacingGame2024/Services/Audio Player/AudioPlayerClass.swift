//
//  AudioPlayerClass.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 15.01.2024.
//

import AVFoundation

private extension String {
    static let format = "mp3"
}

class AudioPlayerClass {
    
    static let shared = AudioPlayerClass()
    
    private var player: AVAudioPlayer?
    
    func playSound(sound: String) {
        guard let soundURL = Bundle.main.url(forResource: sound, withExtension: String.format) else {return}
        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
            player?.play()
        } catch {
            print(error)
        }
    }
    
    func stopSound() {
        player?.stop()
    }
}
