//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Mirko Jurić-Kavelj on 2/23/16.
//  Copyright © 2016 Mirko Jurić-Kavelj. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer : AVAudioPlayer!
    var echoPlayer : RepetableAudioPlayer!
    var receivedAudio : RecordedAudio!
    var audioEngine : AVAudioEngine!
    var audioFile : AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
            audioPlayer.enableRate = true
            echoPlayer = RepetableAudioPlayer(contentUrl: receivedAudio.filePathUrl, numberOfPlayers: 3, baselineDelay: 1)
        } catch {
            print("Error while trying to create audio player")
        }
        
        audioEngine = AVAudioEngine()
        try! audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playSlowSound(sender: AnyObject) {
        playSound(0.5, actionName: "playSlowSound")
    }
    
    @IBAction func playSoundFast(sender: AnyObject) {
        playSound(2.0, actionName: "playSoundFast")
    }
    
    func playSound(rate: float_t, actionName: String) {
        print("Inside " + actionName)
        stopAndReset()
        
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func stopAndReset() {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func playChipmunkSound(sender: AnyObject) {
        print("inside playChipmunkSound")
        
        playAudioWithPitch(1000)
    }
    
    @IBAction func playDarthVaderSound(sender: AnyObject) {
        print("inside playDarthVaderSound")
        
        playAudioWithPitch(-1000)
    }
    
    func playAudioWithPitch(pitch: float_t) {
        stopAndReset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        
        audioEngine.attachNode(changePitchEffect)
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayerNode.play()
    }
    
    @IBAction func playEchoSound(sender: AnyObject) {
        print("inside playEchoSound")
        stopAndReset()
        
        echoPlayer.playReverb(audioPlayer.deviceCurrentTime)
    }
    
    @IBAction func stopPlayback(sender: AnyObject) {
        stopAndReset()
    }
}
