//
//  CalendarUtils.swift
//  CalendarDatePicker
//
//  Created by Paul Yuan on 2014-11-12.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class CalendarUtils
{
    
    //return the number of weeks for the month of the provided date including blank days from the previous month
    class func getNumberOfWeeksForMonth(date:NSDate) -> CGFloat
    {
        let calendar:NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        
        let firstDay:NSDate = self.getFirstDayOfMonth(date)
        let firstDayDayOfWeek:Int = self.getDayOfWeek(firstDay)
        let days:NSRange = calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitMonth, forDate: date)
        let numDays:Int = days.length + firstDayDayOfWeek - 1
        
        let numWeeks:CGFloat = CGFloat(ceil(Double(numDays) / Double(CalendarWeekCell.NUM_DAYS_IN_WEEK)))
        return numWeeks
    }
    
    //return the number of days in the month
    class func getNumberOfDaysForMonth(date:NSDate) -> Int
    {
        let calendar:NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        let days:NSRange = calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitMonth, forDate: date)
        let numDays:Int = days.length
        return numDays
    }
    
    //return the first day of the month of the provided date
    class func getFirstDayOfMonth(date:NSDate) -> NSDate
    {
        let calendar:NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        let comps:NSDateComponents = calendar.components((NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay), fromDate: date)
        comps.day = 1
        let firstDayOfMonth:NSDate = calendar.dateFromComponents(comps)!
        return firstDayOfMonth
    }
    
    //return the last day of the month of the provided date
    class func getLastDayOfMonth(date:NSDate) -> NSDate
    {
        let calendar:NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        let comps:NSDateComponents = calendar.components((NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay), fromDate: date)
        let numDays = self.getNumberOfDaysForMonth(date)
        comps.day = numDays
        let lastDayOfMonth:NSDate = calendar.dateFromComponents(comps)!
        return lastDayOfMonth
    }
    
    //return the day of the week for the provided date 
    class func getDayOfWeek(date:NSDate) -> Int
    {
        let calendar:NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        let comps:NSDateComponents = calendar.components(NSCalendarUnit.CalendarUnitWeekday, fromDate: date)
        let weekday:Int = comps.weekday
        return weekday
    }
    
    //return the day of the month for the provided date
    class func getDayOfMonth(date:NSDate) -> Int
    {
        let calendar:NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        let comps:NSDateComponents = calendar.components(NSCalendarUnit.CalendarUnitDay, fromDate: date)
        let monthday:Int = comps.day
        return monthday
    }
    
}