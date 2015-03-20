//
//  HeaderView.swift
//  QandA
//
//  Created by trvslhlt on 3/11/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var label: UILabel!

    
    func loadHeaderView(whatToShow: String, todaysQuestionId: String, resultOfYesterdayId: String) {
        
        if whatToShow == "Question" {
            NSBundle.mainBundle().loadNibNamed("QuestionHeaderView", owner: self, options: nil)
            
            self.addSubview(self.view)
            self.view.frame = self.frame
            
            // Run a model that displays today's question
            RetrieveTodaysQuestion().todaysQuestionQuestion(todaysQuestionId, completionHandler: {(todaysQuestionQuestion: String) -> Void in
                self.label.text = todaysQuestionQuestion
            })
        
        } else if whatToShow == "Result" {
            NSBundle.mainBundle().loadNibNamed("ResultHeaderView", owner: self, options: nil)
            
            self.addSubview(self.view)
            self.view.frame = self.frame
            
            // Run a Model that displays yesterday's result, modifying code below
            RetrieveResultOfYesterday().resultOfYesterdayQuestion(resultOfYesterdayId, completionHandler: {(resultOfYesterdayQuestion: String) -> Void in
                self.label.text = resultOfYesterdayQuestion
            })
            
        }
     
        
    }
    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
    
        // loadHeaderView()
        
        //    self.setTranslatesAutoresizingMaskIntoConstraints(false)
        //
        //    let top = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0)
        //    let bottom = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)
        //    let left = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0)
        //    let right = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0)
        //
        //    self.addConstraints([top, bottom, left, right])
//    }

}

