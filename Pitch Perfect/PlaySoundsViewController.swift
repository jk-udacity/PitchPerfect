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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            let sound = NSURL(fileURLWithPath: filePath)
            do {
                audioPlayer = try AVAudioPlayer(contentsOfURL: sound)
                audioPlayer.enableRate = true
            } catch {
                print("Error while trying to create audio player")
            }
        } else {
            print("Couldn't load sound file")
        }
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
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    
    @IBAction func stopPlayback(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
