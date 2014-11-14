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
    @IBOutlet var todayBtn:UIBarButtonItem?
    @IBOutlet var selectedBtn:UIBarButtonItem?
    
    var delegate:CalendarDatePickerControllerDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.todayBtn?.tintColor = CalendarConstants.COLOR_RED
        self.selectedBtn?.tintColor = CalendarConstants.COLOR_BLACK
        
        //register month cell nib
        let monthNib:UINib = UINib(nibName: "CalendarMonthCell", bundle: nil)
        self.tableView?.registerNib(monthNib, forCellReuseIdentifier: CalendarMonthCell.CELL_REUSE_ID)
        self.tableView?.layoutMargins = UIEdgeInsetsZero
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView?.showsHorizontalScrollIndicator = false
        self.tableView?.showsVerticalScrollIndicator = false
        
        //scroll to default date
        let today:NSDate = NSDate()
        let selectedDate:NSDate? = CalendarModel.sharedInstance.selectedDate
        let showDate:NSDate = selectedDate == nil ? today : selectedDate!
        self.goTo(showDate, animated: false)
    }
    
    //scroll to show the month containing today
    @IBAction func goToToday(sender:AnyObject?) {
        let today:NSDate = NSDate()
        self.goTo(today, animated: true)
    }
    
    //scroll to show the selected month, to go today if no selected date
    @IBAction func goToSelectedDay(sender:AnyObject?) {
        let selectedDate:NSDate? = CalendarModel.sharedInstance.selectedDate
        selectedDate != nil ? self.goTo(selectedDate!, animated: true) : self.goToToday(nil)
    }
    
    //set the default selected date
    func setDefaultSelectedDate(date:NSDate?) {
        CalendarModel.sharedInstance.selectedDate = date
    }
    
    //scroll to show entire specified month
    private func goTo(date:NSDate, animated:Bool)
    {
        let year:Int = CalendarUtils.getYearFromDate(date)
        let month:Int = CalendarUtils.getMonthFromDate(date)
        let date:NSDate = CalendarUtils.createDate(year, month: month, day: 1)
        let indexPath:NSIndexPath = self.getIndexPathForDate(date)
        self.tableView?.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: animated)
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
        let year:Int = self.getYearFromIndexPath(indexPath)
        let month:Int = indexPath.row + 1
        let day:Int = 1
        
        let date:NSDate = CalendarUtils.createDate(year, month: month, day: day)
        return date
    }
    
    //get the NSIndexPath of a date
    private func getIndexPathForDate(date:NSDate) -> NSIndexPath
    {
        let year:Int = CalendarUtils.getYearFromDate(date)
        let row:Int = CalendarUtils.getMonthFromDate(date) - 1 //because month starts from 1
        let section:Int = self.getSectionFromYear(year)
        let indexPath:NSIndexPath = NSIndexPath(forRow: row, inSection: section)
        return indexPath
    }
    
    //get the year being viewed based on the NSIndexPath
    private func getYearFromIndexPath(indexPath:NSIndexPath) -> Int
    {
        let today:NSDate = NSDate()
        let totalNumYears:Int = Int(CalendarConstants.CALENDAR_SIZE.TOTAL_NUM_YEARS.rawValue)
        var year:Int = CalendarUtils.getYearFromDate(today)
        if indexPath.section >= indexPath.section/2 {
            year += indexPath.section - Int(floor(CalendarConstants.CALENDAR_SIZE.TOTAL_NUM_YEARS.rawValue/2))
        } else {
            year -= Int(CalendarConstants.CALENDAR_SIZE.TOTAL_NUM_YEARS.rawValue/2) - indexPath.section
        }
        return year
    }
    
    //get the section for a year
    private func getSectionFromYear(year:Int) -> Int
    {
        let today:NSDate = NSDate()
        let currentYear:Int = CalendarUtils.getYearFromDate(today)
        let diff:Int = currentYear - year
        let totalNumYears:Int = Int(CalendarConstants.CALENDAR_SIZE.TOTAL_NUM_YEARS.rawValue)
        let section:Int = Int(floor(Double(totalNumYears)/2)) - diff
        return section
    }
    
    /**** delegate methods ****/
    func calendarMonthOnDaySelected(day: NSDate) {
        self.tableView?.reloadData()
        self.delegate?.calendarDatePickerOnDaySelected(day)
        println(day)
    }
    
}