//
//  CalendarModel.swift
//  CalendarDatePicker
//
//  Created by Paul Yuan on 2014-11-13.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation

class CalendarModel
{
    
    var selectedDate:NSDate?
    
    // get shared instance
    class var sharedInstance: CalendarModel {
        struct Static {
            static var instance: CalendarModel?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = CalendarModel()
        }
        
        return Static.instance!
    }
    
}