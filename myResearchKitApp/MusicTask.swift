//
//  MusicTask.swift
//  myResearchKitApp
//
//  Created by Andong Zhan on 5/22/16.
//  Copyright © 2016 Andong Zhan. All rights reserved.
//

import ResearchKit

public var MusicTask: ORKOrderedTask {
    var steps = [ORKStep]()
    
    let instructionStep = ORKInstructionStep(identifier: "instruction")
    instructionStep.title = "Music + Heart Rate"
    instructionStep.text = "Please listen to a randomized music clip for 30 seconds, and we'll record your heart rate."
    
    steps += [instructionStep]
    
    // add recorder configuration
    let configuration = ORKHealthQuantityTypeRecorderConfiguration(identifier: "heartRateConfig", healthQuantityType: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!, unit: HKUnit(fromString: "count/min"))
    
    
    // add Music Step
    let musicStep = MusicStep(identifier: "music")
    musicStep.clip = MusicClip.random()
    
    musicStep.stepDuration = 30
    musicStep.recorderConfigurations = [configuration]
    
    musicStep.shouldShowDefaultTimer = true
    musicStep.shouldStartTimerAutomatically = true
    musicStep.shouldContinueOnFinish = true
    musicStep.title = "Please listen for 30 seconds"
    
    steps += [musicStep]
    
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Thank you!"
    summaryStep.text = "You have helped us research music and heart rate!"
    
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "MusicTask", steps: steps)
}
