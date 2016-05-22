//
//  ConsentDocument.swift
//  myResearchKitApp
//
//  Created by Andong Zhan on 5/21/16.
//  Copyright © 2016 Andong Zhan. All rights reserved.
//

import ResearchKit


public var ConsentDocument: ORKConsentDocument{
    let consentDocument = ORKConsentDocument()
    consentDocument.title = "Example Consent"
    
    // conset sections
    let consentSectionTypes: [ORKConsentSectionType] = [
        .Overview,
        .DataGathering,
        .Privacy,
        .DataUse,
        .TimeCommitment,
        .StudySurvey,
        .StudyTasks,
        .Withdrawing
    ]
    
    let consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
        let consentSection = ORKConsentSection(type: contentSectionType)
        consentSection.summary = "If you wish to complete this study..."
        consentSection.content = "In this study you will be asked five (wait, no, three!) questions. You will also have your voice recorded for ten seconds."
        return consentSection
        
    }
    
    consentDocument.sections = consentSections
    
    // signature
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}