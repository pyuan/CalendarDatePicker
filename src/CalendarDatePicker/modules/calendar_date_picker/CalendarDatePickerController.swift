//
//  CalendarDatePickerController.swift
//  CalendarDatePicker
//
//  Created by Paul Yuan on 2014-11-11.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class CalendarDatePickerController:UIViewController, UITableViewDataSource, UITableViewDelegate
{

    @IBOutlet var tableView:UITableView?
    
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 44//tableView.frame.height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:CalendarMonthCell = tableView.dequeueReusableCellWithIdentifier(CalendarMonthCell.CELL_REUSE_ID) as CalendarMonthCell
        
        let today:NSDate = NSDate()
        let totalNumYears:Int = Int(CalendarConstants.CALENDAR_SIZE.TOTAL_NUM_YEARS.rawValue)
        var year:Int = CalendarUtils.getYearFromDate(today)
        if indexPath.section >= indexPath.section/2 {
            year += indexPath.section - Int(CalendarConstants.CALENDAR_SIZE.TOTAL_NUM_YEARS.rawValue/2)
        } else {
            year -= Int(CalendarConstants.CALENDAR_SIZE.TOTAL_NUM_YEARS.rawValue/2) - indexPath.section
        }
        
        var month:Int = indexPath.row + 1
        var day:Int = 1

        var date:NSDate = CalendarUtils.createDate(year, month: month, day: day)
        println(date)
        cell.setDate(date)
        
        return cell
    }
    
}