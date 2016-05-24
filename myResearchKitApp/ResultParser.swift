//
//  ResultParser.swift
//  myResearchKitApp
//
//  Created by Andong Zhan on 5/22/16.
//  Copyright © 2016 Andong Zhan. All rights reserved.
//

import Foundation
import ResearchKit

struct ResultParser {
    
    static func findWalkHeartFiles(result: ORKTaskResult) -> [NSURL]
    {
        var urls = [NSURL]()
        
        if let results = result.results
            where results.count > 4,
            let walkResult = results[3] as? ORKStepResult,
            let restResult = results[4] as? ORKStepResult {
            
            // find ORKFileResults
            for result in walkResult.results! {
                if let result = result as? ORKFileResult,
                    let fileUrl = result.fileURL {
                    urls.append(fileUrl)
                }
            }
            
            for result in restResult.results! {
                if let result = result as? ORKFileResult,
                    let fileUrl = result.fileURL {
                    urls.append(fileUrl)
                }
            }
        }
        return urls
    }
    
    static func findMusicHeartFiles(result: ORKTaskResult) -> NSURL? {
        if let results = result.results where results.count > 1,
            let heartResult = results[1] as? ORKStepResult,
            let heartSubresults = heartResult.results where heartSubresults.count > 0,
            let fileResult = heartSubresults[0] as? ORKFileResult,
            let fileURL = fileResult.fileURL {
            return fileURL
        }
        
        return nil
    }
    
    static func findClip(task: ORKTask?) -> MusicClip? {
        if let task = task as? ORKOrderedTask where task.steps.count > 1,
            let musicStep = task.steps[1] as? MusicStep {
            return musicStep.clip
        } else {
            return nil
        }
    }
}
