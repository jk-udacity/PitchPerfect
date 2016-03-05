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
    var numberOfReverbPlayers : Int
    var reverbPlayers : [AVAudioPlayer] = []
    
    init(contentUrl : NSURL, numberOfPlayers : Int, baselineDelay : NSTimeInterval) {
        self.numberOfReverbPlayers = numberOfPlayers
        self.baselineDelay = baselineDelay
        
        for i in 0...numberOfReverbPlayers {
            do {
                let player = try AVAudioPlayer(contentsOfURL: contentUrl)
                let exponent:Double = -Double(i)/Double(numberOfReverbPlayers/2)
                let volume = Float(pow(Double(M_E), exponent))
                print("Volume \(volume)") // TODO delete
                player.volume = volume
                reverbPlayers.append(player)
            } catch {
                print("Error creating \(i)th player")
            }
        }
        print("Done creating reverb players.")
    }
    
    func playReverb(deviceCurrentTime : NSTimeInterval) {
        for (i, player) in reverbPlayers.enumerate() {
            let delay : NSTimeInterval = baselineDelay * NSTimeInterval(i)
            player.playAtTime(deviceCurrentTime + delay)
        }
    }
}