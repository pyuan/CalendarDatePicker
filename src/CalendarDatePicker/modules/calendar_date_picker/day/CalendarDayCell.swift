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
        
        if date != nil
        {
            //populate label
            var dayOfMonth:Int = CalendarUtils.getDayOfMonth(date!)
            self.label?.text = dayOfMonth.description
        }
        
        self.setLabel(self.selected)
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
        
        if self.date != nil {
            self.backgroundLayer?.backgroundColor = selected ? CalendarConstants.COLOR_RED.CGColor : UIColor.clearColor().CGColor
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
        
        if selected {
            font = UIFont.boldSystemFontOfSize(fontSize)
            color = UIColor.whiteColor()
        }
        
        self.label?.textColor = color
        self.label?.font = font
    }
    
    //getter for the date
    func getDate() -> NSDate? {
        return self.date
    }
    
}