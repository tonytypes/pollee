//
//  BodyView.swift
//  ParseStarterProject
//
//  Created by Tony Ruiz on 3/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class BodyView: UIView {

    func loadBodyView(whatToShow: String, todaysQuestionId: String, resultOfYesterdayId: String) {
        if whatToShow == "Question" {
            
            if let q = QuestionBodyView.loadFromNibNamed("QuestionBodyView", bundle: nil) as? QuestionBodyView {
                // q.setTranslatesAutoresizingMaskIntoConstraints(false) // Appears that I don't need this, and AutoLayout still works
                q.frame = self.frame
                self.addSubview(q)
                
                var heightFloat: CGFloat = 180
                
                // Set constraints for QuestionBodyView nib
                let left = NSLayoutConstraint(item: q, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
                let right = NSLayoutConstraint(item: q, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0)
                let height = NSLayoutConstraint(item: q, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: heightFloat)
                let width = NSLayoutConstraint(item: q, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0)
                self.addConstraints([left, right, height, width])
                
                //Retrieve answer options from Parse.com
                RetrieveTodaysQuestion().todaysQuestionAnswers(todaysQuestionId, completionHandler: {(firstAnswerTitle: String, secondAnswerTitle: String) -> Void in
                    q.firstAnswerButton.setTitle(firstAnswerTitle, forState: UIControlState.Normal)
                    q.secondAnswerButton.setTitle(secondAnswerTitle, forState: UIControlState.Normal)
                })
                

            }
            
        

            
            
        /* } else if whatToShow == "Result" {
            NSBundle.mainBundle().loadNibNamed("ResultHeaderView", owner: self, options: nil)
            
            self.addSubview(self.view)
            self.view.frame = self.frame
            
            // Run a Model that displays yesterday's result, modifying code below
            RetrieveResultOfYesterday().resultOfYesterdayQuestion(resultOfYesterdayId, completionHandler: {(resultOfYesterdayQuestion: String) -> Void in
                self.label.text = resultOfYesterdayQuestion
            }) */
            
        }
        
        
    }



}
