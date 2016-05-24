//
//  ViewController.swift
//  myResearchKitApp
//
//  Created by Andong Zhan on 5/21/16.
//  Copyright © 2016 Andong Zhan. All rights reserved.
//

import UIKit
import ResearchKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let myStep = ORKInstructionStep(identifier: "intor")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: ORKTaskViewControllerDelegate{
    func taskViewController(taskViewController: ORKTaskViewController, viewControllerForStep step: ORKStep) -> ORKStepViewController? {
        if step.identifier == "music" {
            return MusicStepViewController(step: step)
        }else{
            return nil
        }
    }
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason,
                            error: NSError?){
        HealthKitManager.stopMockHeartData()
        
        if (taskViewController.task?.identifier == "MusicTask" && reason == .Completed){
            let clip = ResultParser.findClip(taskViewController.task)
            print("clip name: \(clip!.rawValue)")
            
            let heartURL = ResultParser.findMusicHeartFiles(taskViewController.result)
            if let heartURL = heartURL {
                do {
                    let string = try NSString.init(contentsOfURL: heartURL, encoding: NSUTF8StringEncoding)
                    print(string)
                } catch {}
            }
        }
        
        if (taskViewController.task?.identifier == "WalkTask" && reason == .Completed){
            let heartURLs = ResultParser.findWalkHeartFiles(taskViewController.result)
            
            for url in heartURLs {
                do{
                    let string = try NSString.init(contentsOfURL: url, encoding: NSUTF8StringEncoding)
                    print(string)
                } catch {}
            }
        }
        
        
        
        // Handle results with taskViewController.result
        switch reason{
        case .Completed:
            let taskResult = taskViewController.result
            print(taskResult)
        default:
            print("task incomplete!")
        }
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func walkTapped(sender: AnyObject) {
        let taskViewController = ORKTaskViewController(task: WalkTask, taskRunUUID: nil)
        taskViewController.delegate = self
        taskViewController.outputDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0],
                                                   isDirectory: true
        )
        presentViewController(taskViewController, animated: true, completion: nil)
        HealthKitManager.startMockHeartData()
    }
    
    @IBAction func authorizeTapped(sender: AnyObject) {
        HealthKitManager.authorizeHealthKit()
    }
    
    @IBAction func consentTapped(sender: AnyObject){
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }
    
    @IBAction func microphoneTapped(sender: AnyObject) {
        let taskViewController = ORKTaskViewController(task: MicrophoneTask, taskRunUUID: nil)
        taskViewController.delegate = self
        taskViewController.outputDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0], isDirectory: true)
        presentViewController(taskViewController, animated: true, completion: nil)
    }
    
    @IBAction func surveyTapped(sender: AnyObject) {
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }
    
    @IBAction func musicTapped(sender: AnyObject) {
        let taskViewController = ORKTaskViewController(task: MusicTask, taskRunUUID: nil)
        taskViewController.delegate = self
        taskViewController.outputDirectory = NSURL(fileURLWithPath:
            NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0],
                                                   isDirectory: true)
        presentViewController(taskViewController, animated: true, completion: nil)
        HealthKitManager.startMockHeartData()
    }
}

