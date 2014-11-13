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
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        //setup styles for label
        self.label = UILabel(frame: frame)
        self.label?.text = "MONTH"
        self.label?.textAlignment = NSTextAlignment.Center
        self.label?.textColor = CalendarConstants.COLOR_RED
        self.label?.sizeToFit()
        self.addSubview(self.label!)
    }
    
    //set the label based on the provided date
    func setMonth(date:NSDate)
    {
        let firstDayOfMonth:NSDate = CalendarUtils.getFirstDayOfMonth(date)
        let today:NSDate = NSDate()
        
        //set text of label
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "MMM"
        let month:String = formatter.stringFromDate(firstDayOfMonth)
        let currentMonth:String = formatter.stringFromDate(today)
        
        self.label?.text = month.uppercaseString
        self.label?.textColor = month == currentMonth ? CalendarConstants.COLOR_RED : CalendarConstants.COLOR_BLACK
        self.label?.sizeToFit()
        
        //position label
        let weekday:Int = CalendarUtils.getDayOfWeek(firstDayOfMonth) - 1 //sunday starts at 1
        let dayWidth:CGFloat = self.frame.width / CalendarWeekCell.NUM_DAYS_IN_WEEK
        let x:CGFloat = CGFloat(weekday) * dayWidth
        let y:CGFloat = 0
        self.label?.frame = CGRectMake(x, y, dayWidth, self.frame.height)
    }
    
}