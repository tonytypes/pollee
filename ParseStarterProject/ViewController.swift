//
//  ViewController.swift
//  QandA
//
//  Created by trvslhlt on 3/11/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var headerView: HeaderView!
    
    // Below 2 vars will be omitted once they can be determined with Parse.com, maybe in the same query to Result Parse class?
    var todaysQuestionId: String = "SfjfegusPV"
    var resultOfYesterdayId: String = "SfjfegusPV" // The result that is scheduled for display today
    
    // Below will be omitted once viewToShow is determined with Parse.com
    var viewToShow: String? // = "Result" // either "Question" or "Result"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Run a model that syncronously checks for presence of result
        CheckForResponse().responseIsPresent(self.todaysQuestionId, completionHandler: {(present: Bool) -> Void in
            if present == true {
                self.viewToShow = "Result"
            } else if present == false {
                self.viewToShow = "Question"
            }
            if let vts = self.viewToShow {
                self.headerView.loadHeaderView(vts, todaysQuestionId: self.todaysQuestionId, resultOfYesterday: self.resultOfYesterdayId)
            }
        })
                 // questionHeaderView.label.text = "What is this?"
    
    }
    
}


/*-------------------------------
This is all of my test code for Parse.com queries.
    
    

//    var result: PFObject?
//    var syncTest: String?
    
    func displayObject(result: PFObject) {
        println("In function:\n\(result)")
    }
    
    override func viewDidLoad() {
        
        //// What will need to happen
        // Check if logged in.
            // If NO: Show login
            // If YES:
                // Check if user has answered yesterday's question:
                    // If NO: Show today's question
                    // If YES:
                        // Check if yesterday's result is available:
                            // If NO: Display some kind of placeholder (for short window between answer submissions closing, and when the result is posted after calculations
                            // If YES: Display yesterday's result
        // Somewhere, need to deal with network connection issues
        
        
        super.viewDidLoad()
        // saveObject(setup())
        getResult("SfjfegusPV") // questionId // This will also displayResult
//        println(self.result)
//        println(self.syncTest)

        //// CRAP! This will run okay, but I can't make this work with returns. CRAP.
        
        // var result = getResult("SfjfegusPV") as [String: NSObject]
        // println("Result: \(result)")
//        for key in result.keys {
//            println("Key: \(key)")
//        }
    }


    /*
    //// This is the synchronous version
    func getResult(questionId: String) {
        
        
        func showResult(resultObject: PFObject) /* -> [PFObject]*/ {
            println("Results for yesterday's question were retrieved.")
            // return resultObject["resultObject"] as (PFObject)
            println(resultObject["answer"])
            // return resultObject
        }
        
        var resultQuery = PFQuery(className:"Response")
        resultQuery.whereKey("answeredFor", equalTo: PFObject(withoutDataWithClassName:"Question", objectId:questionId))
        var objects = resultQuery.findObjects(NSErrorPointer())
        
            
        
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) responses.")
                if objects.count == 0 {
                    // function to run if this user DID NOT answer this question
                    // show today's question
                    println("Didn't find any objects")
                } else {
                    // function to run if this user DID answer this question
                    // show results of yesterday's question
                    
                    // Do something with the found objects.
                    if let objects = objects as? [PFObject] {
                        for object in objects {
                            //                            println(object.objectId)
                            //                            println(object)
                            // showResult(object)
                            self.result = object
                            self.syncTest = "Here is the result of the sync test"
                        }
                    }
                }
                
            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
        }
    }
    */
    

    //// This is asynchronous
    
    // Retrieve the Result
    func getResult(questionId: String) {
        
        var resultObject: PFObject?
        
//        let showResult = { () -> () in
//            println("Results for yesterday's question were retrieved.")
//            // return resultObject["resultObject"] as (PFObject)
//            println(object["answer"])
//            resultObject = object
//        }
        
        var resultQuery = PFQuery(className:"Response")
        resultQuery.whereKey("answeredFor", equalTo: PFObject(withoutDataWithClassName:"Question", objectId:questionId))
        resultQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) responses.")
                if objects.count == 0 {
                    // function to run if this user DID NOT answer this question
                    // show today's question
                    println("Didn't find any objects")
                } else {
                    // function to run if this user DID answer this question
                    // show results of yesterday's question
                    
                    // Do something with the found objects.
                    if let objects = objects as? [PFObject] {
                        for object in objects {
//                            println(object.objectId)
//                            println(object)
                            resultObject = object
                            // self.result = object
                            // self.syncTest = "Here is the result of the sync test"
                        }
                    }
                }
            
                dispatch_async(dispatch_get_main_queue(), {
                    if let r = resultObject {
                        self.displayObject(r)
                    }
                })
                
            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
        }
//        if let r = resultObject {
//            return r
//        }
//        return nil
    }
    
    
    
    
    
    
    // TEST: Create a resultObject with the array of dictionaries needed
    /*
    // Set vars for question and answers
    let question = "Have you ever stolen (even something small)?"
    let firstAnswer: String = "Yes"
    let secondAnswer: String = "No"
    
    
    // Create the resultObject array and dictionarie(s)
    // var resultObject = [String: NSObject]()
    
    func setup() -> [String: NSObject] {
        
        var resultObject = [String: NSObject]()
        
        let resultTotal = [
            firstAnswer:[
                "num":"60%",
                "desc":"have done it"
            ],
            secondAnswer:[
                "num":"40%",
                "desc":"are angels"
            ],
            "desc":"Most people said Yes"
        ]
        resultObject["total"] = resultTotal
        // end the zeroeth array item
        
        let resultLikelihood = [
            "most_likely_desc":"Females 13-17 were most likely to answer Yes",
            "most_likely_num":"89%",
            "least_likely_desc":"Males 55+ were least likely to answer Yes",
            "least_likely_num":"2%"
        ]
        resultObject["likelihood"] = resultLikelihood
        // end the first array item
        
        let resultGender = [
            "males":[
                firstAnswer:0.1,
                secondAnswer:0.9
            ],
            "females":[
                firstAnswer:0.8,
                secondAnswer:0.2
            ]
        ]
        resultObject["gender"] = resultGender
        // end the second array item
        
        
        let resultAge = [
            "13-17":[
            firstAnswer:0.75,
            secondAnswer:0.25
            ],
            "18-24":[
            firstAnswer:0.7,
            secondAnswer:0.3
            ],
            "25-34":[
            firstAnswer:0.6,
            secondAnswer:0.4
            ],
            "35-54":[
            firstAnswer:0.3,
            secondAnswer:0.7
            ],
            "55+":[
            firstAnswer:0.25,
            secondAnswer:0.75
            ]
        ]
        resultObject["age"] = resultAge
        // end the third array item
        
        let resultSurprising = [
            "desc":"Males and females 35-54 were just as likely to answer Yes"
        ]
        resultObject["surprising"] = resultSurprising
        // end fourth array item
        
        return resultObject
    }
    
    func saveObject(resultObject:[String: NSObject]) {
        // Declare variable for the pointer that will go in resultFor column
        let resultFor = PFObject(withoutDataWithClassName:"Question", objectId:"SfjfegusPV")
        let passedResultObject = resultObject
        
        var result = PFObject(className:"Result")
        result.setObject(passedResultObject, forKey: "resultObject")
        result["resultFor"] = resultFor
        result.saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if (success) {
                // The object has been saved.
                println("The object has been saved")
                println(passedResultObject)
            } else {
                // There was a problem, check error.description
                println("Problem. Object wasn't saved.")
            }
        }
    }
    */
    
    
    
    
        /*
        // Check for existence of Response for one Question by currentUser. (Mark it with a bool variable.)
        var questionId = "SfjfegusPV" // ID of today's question
        var user = PFUser.currentUser()
        var didAnswerQuestion: Bool?
        
        // Func to run if this user DID NOT answer today's question
        func showQuestion() {
            println("User has not yet answered today's question")
        }
        
        // Func to run if this user DID answer today's question
        func showResult(object:PFObject) {
            println("User has already answered today's question")
            println(object.objectId)
        }
        
        var responseQuery = PFQuery(className:"Response")
        responseQuery.whereKey("answeredFor", equalTo: PFObject(withoutDataWithClassName:"Question", objectId:questionId))
        responseQuery.whereKey("answeredBy", equalTo:user)
        responseQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) responses.")
                if objects.count == 0 {
                    didAnswerQuestion = false
                    // function to run if this user DID NOT answer this question
                    // show today's question
                    showQuestion()
                } else {
                    didAnswerQuestion = true
                    // function to run if this user DID answer this question
                    // show results of yesterday's question
                    
                    // Do something with the found objects.
                    if let objects = objects as? [PFObject] {
                        for object in objects {
//                            println(object.objectId)
//                            println(object)
                            showResult(object)
                        }
                    }
                }

            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
        }
        */
    
    
    
        
        // Retrieve one Question (using QuestionId)
        /*
        // This is the question I want users to answer
        var questionId = "BPd15JqiPt" // ID of today's question
        
        var questionQuery = PFQuery(className:"Question")
        questionQuery.getObjectInBackgroundWithId(questionId) {
            (question: PFObject!, error: NSError!) -> Void in
            if error == nil && question != nil {
                println(question)
            } else {
                println(error)
            }
        }
        */
        
    
    
    
        // Create one Response
        /*
        var answeredFor = PFObject(withoutDataWithClassName:"Question", objectId:"SfjfegusPV")
        
        var response = PFObject(className:"Response")
        response["answer"] = "Yes"
        response["answeredFor"] = answeredFor
        response["answeredBy"] = PFUser.currentUser()
        // saveInBackground() would work too. Rudd showed us.
        response.saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if (success) {
                // The object has been saved.
                println("The object has been saved")
            } else {
                // There was a problem, check error.description
                println("Problem. Object wasn't saved.")
            }
        }
        */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
*/
