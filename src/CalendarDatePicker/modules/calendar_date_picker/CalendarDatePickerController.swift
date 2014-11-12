//
//  CalendarDatePickerController.swift
//  CalendarDatePicker
//
//  Created by Paul Yuan on 2014-11-11.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class CalendarDatePickerController:UIViewController, UITableViewDataSource, UITableViewDelegate
{

    @IBOutlet var tableView:UITableView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //register week cell nib
        let weekNib:UINib = UINib(nibName: "CalendarWeekCell", bundle: nil)
        self.tableView?.registerNib(weekNib, forCellReuseIdentifier: CalendarWeekCell.CELL_REUSE_ID)
        self.tableView?.layoutMargins = UIEdgeInsetsZero
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        
        //set month header
        let frame:CGRect = CGRectMake(0, 0, self.view.frame.width, CGFloat(CalendarConstants.CALENDAR_SIZE.MONTH_START_ROW_HEIGHT.rawValue))
        var monthHeader:CalendarMonthHeaderCell = CalendarMonthHeaderCell(frame: frame)
        self.tableView?.tableHeaderView = monthHeader
        
        var today:NSDate = NSDate()
        var calendar:NSCalendar = NSCalendar.currentCalendar()
        var days:NSRange = calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.MonthCalendarUnit, forDate: today)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(self.getNumberOfRows(section))
    }
    
    private func getNumberOfRows(section:Int) -> CGFloat {
        return 6
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let h:CGFloat = (tableView.frame.height - CGFloat(CalendarConstants.CALENDAR_SIZE.MONTH_START_ROW_HEIGHT.rawValue)) / self.getNumberOfRows(indexPath.section)
        return h
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:CalendarWeekCell = tableView.dequeueReusableCellWithIdentifier(CalendarWeekCell.CELL_REUSE_ID) as CalendarWeekCell
        return cell
    }
    
}