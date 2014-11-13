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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clearColor()
    }
    
    //update text and style
    func update(date:NSDate)
    {
        self.date = date
        
        //populate label
        var dayOfMonth:Int = CalendarUtils.getDayOfMonth(date)
        self.label?.text = dayOfMonth.description
        
        //set color
        var dayOfWeek:Int = CalendarUtils.getDayOfWeek(date)
        self.label?.textColor = dayOfWeek == 6 || dayOfWeek == 7 ? CalendarConstants.COLOR_GREY : CalendarConstants.COLOR_BLACK
    }
    
}