//
//  CalendarMonthHeaderCell.swift
//  CalendarDatePicker
//
//  Created by Paul Yuan on 2014-11-12.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class CalendarMonthHeaderCell:UIView
{
    
    private var label:UILabel?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.label = UILabel(frame: frame)
        self.label?.text = "JAN"
        self.label?.textAlignment = NSTextAlignment.Center
        self.label?.textColor = CalendarConstants.COLOR_RED
        self.addSubview(self.label!)
    }
    
}