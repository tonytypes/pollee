//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // TEST: Create a resultObject with the array of dictionaries needed
        
        // Set vars for question and answers
        var question = "Have you ever stolen (even something small)?"
        var firstAnswer = "Yes"
        var secondAnswer = "No"
        
        // Create the resultObject array and dictionarie(s)
        var resultObject = [
            ["total":[
                firstAnswer:0.6,
                secondAnswer:0.4,
                "desc":"Most people said Yes"
                ]
            ], // end the zeroeth array item
            ["likelihood":[
                "most_likely_desc":"Females 13-17 were most likely to answer Yes",
                "most_likely_num":0.89,
                "least_likely_desc":"Males 65+ were least likely to answer Yes",
                "least_likely_num":0.02
                ]
            ], // end the first array item
            ["gender":[
                "males":[
                    firstAnswer:0.1,
                    secondAnswer:0.9
                    ],
                "females":[
                    firstAnswer:0.8,
                    secondAnswer:0.2
                    ]
                ]
            ], // end the second array item
            ["surprising":[
                "desc":"test"
                ]
            ]
        ]
        
        
        /*
        // Declare variable for the pointer that will go in resultFor column
        var resultFor = PFObject(withoutDataWithClassName:"Question", objectId:"SfjfegusPV")
        
        var result = PFObject(className:"Result")
        result["resultObject"] = resultObject
        result["resultFor"] = resultFor
        result.saveInBackgroundWithBlock {
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

