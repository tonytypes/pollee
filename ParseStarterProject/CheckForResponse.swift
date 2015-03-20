//
//  CheckForResponse.swift
//  ParseStarterProject
//
//  Created by Tony Ruiz on 3/16/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Parse

class CheckForResponse: NSObject {

    func responseIsPresent(todaysQuestionId: String, completionHandler: ((Bool) -> Void)) {
        
        var resultQuery = PFQuery(className:"Response")
        resultQuery.whereKey("answeredFor", equalTo: PFObject(withoutDataWithClassName:"Question", objectId:todaysQuestionId))
        resultQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            // The find succeeded.
            var presence: Bool
            println("Successfully retrieved \(objects.count) responses.")
            if objects.count == 0 {
                // function to run if this user DID NOT answer this question
                // show today's question
                println("Response was not present")
                presence = false
            } else {
                // function to run if this user DID answer this question
                // show results of yesterday's question
                println("Response was present")
                presence = true
            }
            completionHandler(presence)
        }
    }
    // Consider trying this with a KVO pattern and inBlock... rather than running things on the main thread?



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
}
