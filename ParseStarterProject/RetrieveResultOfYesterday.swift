//
//  RetrieveResultOfYesterday.swift
//  ParseStarterProject
//
//  Created by Tony Ruiz on 3/16/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Parse

class RetrieveResultOfYesterday: NSObject {
   
    func resultOfYesterdayQuestion(resultOfYesterdayId: String, completionHandler: ((String) -> Void)) {
        
        var query = PFQuery(className:"Question")
        query.whereKey("objectId", equalTo: resultOfYesterdayId)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            // The find succeeded.
            var resultOfYesterdayQuestion = String()
            println("Successfully retrieved \(objects.count) responses.")
            if objects.count == 0 {
                // function to run if the object wasn't found
                println("Result object was not present")
            } else {
                // function to run if object was found
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println("Result object was present")
                        resultOfYesterdayQuestion = object["question"] as String
                    }
                }
            }
            completionHandler(resultOfYesterdayQuestion)
        }
        
    }
    
}

/*
CODE THAT WOULD ONLY RETURN NIL FOR PRINTLN(QUERY...)

        var innerQuery = PFQuery(className:"Result")
        innerQuery.includeKey("resultFor")
        innerQuery.includeKey("resultFor.objectId")
        innerQuery.whereKey("resultFor", equalTo: PFObject(withoutDataWithClassName:"Question", objectId:resultOfYesterdayId))
        
        println(innerQuery.findObjects())
        
        var query = PFQuery(className:"Question")
        query.whereKey("objectId", matchesKey: "resultFor.objectId", inQuery: innerQuery)
        println(query.findObjects())

*/
