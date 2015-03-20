//
//  RetrieveTodaysQuestion.swift
//  ParseStarterProject
//
//  Created by Tony Ruiz on 3/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Parse

class RetrieveTodaysQuestion: NSObject {
   
    func todaysQuestionQuestion(todaysQuestionId: String, completionHandler: ((String) -> Void)) {
        
        var query = PFQuery(className:"Question")
        query.whereKey("objectId", equalTo: todaysQuestionId)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            // The find succeeded.
            var todaysQuestionQuestion = String()
            println("Successfully retrieved \(objects.count) responses.")
            if objects.count == 0 {
                // function to run if the object wasn't found
                println("Result object was not present")
            } else {
                // function to run if object was found
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println("Result object was present")
                        todaysQuestionQuestion = object["question"] as String
                    }
                }
            }
            completionHandler(todaysQuestionQuestion)
        }
        
    }
    
    
    func todaysQuestionAnswers(todaysQuestionId: String, completionHandler: ((firstAnswerTitle: String, secondAnswerTitle: String) -> Void)) {
        
        var query = PFQuery(className:"Question")
        query.whereKey("objectId", equalTo: todaysQuestionId)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            // The find succeeded.
            var firstAnswerTitle = String()
            var secondAnswerTitle = String()
            println("Successfully retrieved \(objects.count) responses.")
            if objects.count == 0 {
                // function to run if the object wasn't found
                println("Result object was not present")
            } else {
                // function to run if object was found
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println("Result object was present")
                        firstAnswerTitle = object["firstAnswer"] as String
                        secondAnswerTitle = object["secondAnswer"] as String
                    }
                }
            }
            completionHandler(firstAnswerTitle: firstAnswerTitle, secondAnswerTitle: secondAnswerTitle)
        }
        
    }
    
}
