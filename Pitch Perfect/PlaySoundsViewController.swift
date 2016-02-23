//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Mirko Jurić-Kavelj on 2/23/16.
//  Copyright © 2016 Mirko Jurić-Kavelj. All rights reserved.
//

import UIKit

class PlaySoundsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playSlowSound(sender: AnyObject) {
        print("Inside playSlowSound")
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
