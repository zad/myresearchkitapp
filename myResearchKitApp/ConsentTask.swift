//
//  ConsentTask.swift
//  myResearchKitApp
//
//  Created by Andong Zhan on 5/21/16.
//  Copyright © 2016 Andong Zhan. All rights reserved.
//

import ResearchKit

public var ConsentTask: ORKOrderedTask {
    var steps = [ORKStep]()
    
    // Add VisualConsentStep
    let consentDocument = ConsentDocument
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
    steps += [visualConsentStep]
    
    // Add ConsentReviewStep
    let signature = (consentDocument.signatures?.first)! as ORKConsentSignature
    
    let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, inDocument: consentDocument)
    
    reviewConsentStep.text = "Review Consent!"
    reviewConsentStep.reasonForConsent = "Consent to join study"
    
    steps += [reviewConsentStep]
    
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}
