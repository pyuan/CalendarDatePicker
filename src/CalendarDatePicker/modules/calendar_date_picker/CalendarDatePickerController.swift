//
//  CalendarDatePickerController.swift
//  CalendarDatePicker
//
//  Created by Paul Yuan on 2014-11-11.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

protocol CalendarDatePickerControllerDelegate {
    func calendarDatePickerOnDaySelected(day:NSDate)
}

class CalendarDatePickerController:UIViewController, UITableViewDataSource, UITableViewDelegate, CalendarMonthCellDelegate
{

    @IBOutlet var tableView:UITableView?
    
    var delegate:CalendarDatePickerControllerDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //register month cell nib
        let monthNib:UINib = UINib(nibName: "CalendarMonthCell", bundle: nil)
        self.tableView?.registerNib(monthNib, forCellReuseIdentifier: CalendarMonthCell.CELL_REUSE_ID)
        self.tableView?.layoutMargins = UIEdgeInsetsZero
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView?.showsHorizontalScrollIndicator = false
        self.tableView?.showsVerticalScrollIndicator = false
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Int(CalendarConstants.CALENDAR_SIZE.TOTAL_NUM_YEARS.rawValue)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CalendarMonthCell.NUM_MONTHS_IN_YEARS
    }
    
    //set the height for each month, calculate based on the number of weeks for each month
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let date:NSDate = self.getDateForIndexPath(indexPath)
        let numWeeks:Int = CalendarUtils.getNumberOfWeeksForMonth(date)
        let h:CGFloat = CGFloat(CalendarConstants.CALENDAR_SIZE.MONTH_START_ROW_HEIGHT.rawValue) + CGFloat(numWeeks) * CGFloat(CalendarConstants.CALENDAR_SIZE.WEEK_ROW_HEIGHT.rawValue)
        return h
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:CalendarMonthCell = tableView.dequeueReusableCellWithIdentifier(CalendarMonthCell.CELL_REUSE_ID) as CalendarMonthCell
        
        cell.delegate = self
        let date:NSDate = self.getDateForIndexPath(indexPath)
        cell.setDate(date)
        
        return cell
    }
    
    //get the date associated with an NSIndexPath
    private func getDateForIndexPath(indexPath:NSIndexPath) -> NSDate
    {
        let today:NSDate = NSDate()
        let totalNumYears:Int = Int(CalendarConstants.CALENDAR_SIZE.TOTAL_NUM_YEARS.rawValue)
        var year:Int = CalendarUtils.getYearFromDate(today)
        if indexPath.section >= indexPath.section/2 {
            year += indexPath.section - Int(CalendarConstants.CALENDAR_SIZE.TOTAL_NUM_YEARS.rawValue/2)
        } else {
            year -= Int(CalendarConstants.CALENDAR_SIZE.TOTAL_NUM_YEARS.rawValue/2) - indexPath.section
        }
        
        let month:Int = indexPath.row + 1
        let day:Int = 1
        
        let date:NSDate = CalendarUtils.createDate(year, month: month, day: day)
        return date
    }
    
    /**** delegate methods ****/
    func calendarMonthOnDaySelected(day: NSDate) {
        self.tableView?.reloadData()
        self.delegate?.calendarDatePickerOnDaySelected(day)
        println(day)
    }
    
}