//
//  TimeDelayedAudioPlayers.swift
//  Pitch Perfect
//
//  Created by Mirko Jurić-Kavelj on 3/5/16.
//  Copyright © 2016 Mirko Jurić-Kavelj. All rights reserved.
//

import Foundation
import AVFoundation

//
//  This class can be used for effects such as echo and reverb (the ones
//  which depend on delay and multiple audio sources).
//
final class TimeDelayedAudioPlayers: NSObject {
    
    // defines audio delay in seconds
    let baselineDelay : NSTimeInterval
    
    // defines maximum number of audio players which are used
    let numberOfPlayers : Int
    
    var players : [AVAudioPlayer] = []
    
    init(contentUrl : NSURL, numberOfPlayers : Int, baselineDelay : NSTimeInterval) {
        self.numberOfPlayers = numberOfPlayers
        self.baselineDelay = baselineDelay
        
        for i in 0...numberOfPlayers {
            do {
                let player = try AVAudioPlayer(contentsOfURL: contentUrl)
                let exponent : Double = -Double(i) / Double(numberOfPlayers / 2)
                let volume = Float(pow(Double(M_E), exponent))
                player.volume = volume
                players.append(player)
            } catch {
                print("Error creating \(i)th player")
            }
        }
        print("Done creating players.")
    }
    
    // Plays sound multiple times with each one starting 'baselineDelay'
    // seconds after another
    func play() {
        for (i, player) in players.enumerate() {
            let delay : NSTimeInterval = baselineDelay * NSTimeInterval(i)
            player.playAtTime(player.deviceCurrentTime + delay)
        }
    }
    
    // Stops playing every sound.
    func stop() {
        for player in players {
            player.stop()
        }
    }
    
    // Stops playing every sound and resets the sounds to the beginning.
    func stopAndReset() {
        for player in players {
            player.stop()
            player.currentTime = 0
        }
    }
}