//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Mirko Jurić-Kavelj on 2/24/16.
//  Copyright © 2016 Mirko Jurić-Kavelj. All rights reserved.
//

import Foundation

//
// This class is used as the Model of the app. It stores necessary information
// about our recording.
//
final class RecordedAudio: NSObject{
    
    // Path URL to the file of the recording.
    var filePathUrl: NSURL!
    
    // Title of the recording
    var title: String!
    
    init(filePathUrl : NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}