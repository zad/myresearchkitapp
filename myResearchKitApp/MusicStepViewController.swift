//
//  MusicStepViewController.swift
//  myResearchKitApp
//
//  Created by Andong Zhan on 5/22/16.
//  Copyright © 2016 Andong Zhan. All rights reserved.
//

import AVFoundation
import ResearchKit

class MusicStepViewController: ORKActiveStepViewController {
    var audioPlayer: AVAudioPlayer?
    
    override func start() {
        super.start()
        
        if let step = step as? MusicStep {
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: step.clip.fileURL(), fileTypeHint: AVFileTypeMPEGLayer3)
                audioPlayer?.play()
            } catch {}
        }
    }
    
    override func stepDidFinish() {
        super.stepDidFinish()
        audioPlayer?.stop()
    }
}
