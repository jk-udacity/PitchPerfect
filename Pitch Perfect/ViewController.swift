//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Mirko Jurić-Kavelj on 2/20/16.
//  Copyright © 2016 Mirko Jurić-Kavelj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var microphoneButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        stopButton.hidden = true
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordingLabel.hidden = false
        stopButton.hidden = false
        microphoneButton.enabled = false
        //TODO: Record the user's voice
        print("in recordAudio")
    }
    
    
    @IBAction func stopRecording(sender: AnyObject) {
        //TODO: Stop recording user's voice
        print("in stopRecording")
        recordingLabel.hidden = true
        microphoneButton.enabled = true
    }
}

