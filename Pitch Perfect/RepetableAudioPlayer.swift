//
//  RepetableAudioPlayer.swift
//  Pitch Perfect
//
//  Created by Mirko Jurić-Kavelj on 3/5/16.
//  Copyright © 2016 Mirko Jurić-Kavelj. All rights reserved.
//

import Foundation
import AVFoundation

class RepetableAudioPlayer: NSObject {
    
    var baselineDelay : NSTimeInterval
    var numberOfPlayers : Int
    var players : [AVAudioPlayer] = []
    
    init(contentUrl : NSURL, numberOfPlayers : Int, baselineDelay : NSTimeInterval) {
        self.numberOfPlayers = numberOfPlayers
        self.baselineDelay = baselineDelay
        
        for i in 0...numberOfPlayers {
            do {
                let player = try AVAudioPlayer(contentsOfURL: contentUrl)
                let exponent:Double = -Double(i) / Double(numberOfPlayers/2)
                let volume = Float(pow(Double(M_E), exponent))
                player.volume = volume
                players.append(player)
            } catch {
                print("Error creating \(i)th player")
            }
        }
        print("Done creating reverb players.")
    }
    
    func play(deviceCurrentTime : NSTimeInterval) {
        for (i, player) in players.enumerate() {
            let delay : NSTimeInterval = baselineDelay * NSTimeInterval(i)
            player.playAtTime(deviceCurrentTime + delay)
        }
    }
    
    func stop() {
        for player in players {
            player.stop()
        }
    }
    
    func stopAndReset() {
        for player in players {
            player.stop()
            player.currentTime = 0
        }
    }
}