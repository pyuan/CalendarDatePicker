//
//  CalendarDayCell.swift
//  CalendarDatePicker
//
//  Created by Paul Yuan on 2014-11-11.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class CalendarDayCell:UICollectionViewCell
{
    
    class var CELL_REUSE_ID:String { return "day" }
    
    @IBOutlet var label:UILabel?
    
    private var date:NSDate?
    private var backgroundLayer:CALayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clearColor()
    }
    
    //update text and style
    func update(date:NSDate?)
    {
        self.date = date
        self.label?.hidden = self.date == nil
        
        //render if selected
        let selectedDate:NSDate? = CalendarModel.sharedInstance.selectedDate
        if date != nil && selectedDate != nil {
            self.selected = CalendarUtils.sameDay(date!, date2: selectedDate!)
        } else {
            self.selected = false
        }
        
        if date != nil
        {
            //populate label
            var dayOfMonth:Int = CalendarUtils.getDayOfMonth(date!)
            self.label?.text = dayOfMonth.description
        }
        
        self.updateSelected(self.selected)
    }
    
    //update view based on selected
    func updateSelected(selected:Bool)
    {
        self.selected = selected
        self.setBackgroundView(selected)
        self.setLabel(selected)
    }
    
    //draw background for state
    private func setBackgroundView(selected:Bool)
    {
        if self.backgroundLayer == nil
        {
            let margin:CGFloat = 5
            let newSize:CGFloat = self.frame.width - margin * 2
            let frame:CGRect = CGRectMake(margin, margin, newSize, newSize)
            self.backgroundLayer = CALayer()
            self.backgroundLayer!.frame = frame
            self.backgroundLayer!.cornerRadius = newSize / 2
            self.layer.insertSublayer(self.backgroundLayer, atIndex: 0)
        }
        
        let isToday:Bool = self.cellIsToday()
        self.backgroundLayer?.hidden = !self.selected
        if isToday {
            self.backgroundLayer?.hidden = false //always show if today
        }
        
        self.backgroundLayer?.backgroundColor = UIColor.clearColor().CGColor
        if self.date != nil
        {
            var bgColor:CGColorRef = UIColor.clearColor().CGColor
            if selected {
                bgColor = CalendarConstants.COLOR_BLACK.CGColor
            }
            if isToday
            {
                let highlightColor:UIColor = CalendarConstants.COLOR_RED.colorWithAlphaComponent(0.5)
                bgColor = selected ? CalendarConstants.COLOR_RED.CGColor : highlightColor.CGColor
            }
            
            self.backgroundLayer?.backgroundColor = bgColor
        }
    }
    
    //set label color for state
    private func setLabel(selected:Bool)
    {
        var color:UIColor = UIColor.blackColor()
        let fontSize:CGFloat = self.label!.font.pointSize
        var font:UIFont = UIFont.systemFontOfSize(fontSize)
        
        if self.date != nil
        {
            //set color for week days vs weekend days
            var dayOfWeek:Int = CalendarUtils.getDayOfWeek(date!)
            color = dayOfWeek == 1 || dayOfWeek == 7 ? CalendarConstants.COLOR_GREY : CalendarConstants.COLOR_BLACK
        }
        
        let isToday:Bool = self.cellIsToday()
        if selected || isToday {
            font = UIFont.boldSystemFontOfSize(fontSize)
            color = UIColor.whiteColor()
        }
        
        self.label?.textColor = color
        self.label?.font = font
    }
    
    //get if this cell is for today
    private func cellIsToday() -> Bool
    {
        var isToday:Bool = false
        if self.date != nil
        {
            let today:NSDate = NSDate()
            isToday = CalendarUtils.sameDay(self.date!, date2: today)
        }
        return isToday
    }
    
    //getter for the date
    func getDate() -> NSDate? {
        return self.date
    }
    
}