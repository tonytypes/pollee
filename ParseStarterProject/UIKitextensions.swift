//
//  UIKitextensions.swift
//  ParseStarterProject
//
//  Created by Tony Ruiz on 3/19/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}
