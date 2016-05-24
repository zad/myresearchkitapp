//
//  WalkTask.swift
//  myResearchKitApp
//
//  Created by Andong Zhan on 5/22/16.
//  Copyright © 2016 Andong Zhan. All rights reserved.
//

import ResearchKit

public var WalkTask: ORKOrderedTask {
    return ORKOrderedTask.fitnessCheckTaskWithIdentifier("WalkTask",
                                                         intendedUseDescription: nil,
                                                         walkDuration: 15 as NSTimeInterval,
                                                         restDuration: 15 as NSTimeInterval,
                                                         options: .None)
}
