//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Mirko Jurić-Kavelj on 2/20/16.
//  Copyright © 2016 Mirko Jurić-Kavelj. All rights reserved.
//

import UIKit
import AVFoundation

final class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var pauseRecordingButton: UIButton!
    @IBOutlet weak var resumeRecordingButton: UIButton!
    
    // Text constants used to display information to the user
    let recordingText = "Recording..."
    let tapToRecordText = "Tap to Record"
    let resumeRecordingText = "Press Resume to continue recording"
    
    // Declared Globally
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!

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
        infoLabel.hidden = false
        infoLabel.text = tapToRecordText
        pauseRecordingButton.hidden = true
        resumeRecordingButton.hidden = true
    }

    @IBAction func recordAudio(sender: UIButton) {
        print("in recordAudio")
        
        stopButton.hidden = false
        infoLabel.hidden = false
        infoLabel.text = recordingText
        pauseRecordingButton.hidden = false
        microphoneButton.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.meteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    
    @IBAction func pauseRecording(sender: AnyObject) {
        print("in pauseRecording")
        infoLabel.hidden = false
        infoLabel.text = resumeRecordingText
        
        pauseRecordingButton.hidden = true
        resumeRecordingButton.hidden = false
        
        audioRecorder.pause()
    }
    
    @IBAction func resumeRecording(sender: AnyObject) {
        print("in resumeRecording")
        infoLabel.hidden = false
        infoLabel.text = recordingText
        
        resumeRecordingButton.hidden = true
        pauseRecordingButton.hidden = false
        
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        print("in stopRecording")
        infoLabel.hidden = true
        microphoneButton.enabled = true
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag) {
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            print("Recording failed")
            microphoneButton.enabled = true
            stopButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording") {
            let playSoundsVC : PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
}

