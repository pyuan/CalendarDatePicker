//
//  CalendarMonthCell.swift
//  CalendarDatePicker
//
//  Created by Paul Yuan on 2014-11-12.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class CalendarMonthCell:UITableViewCell, UITableViewDataSource, UITableViewDelegate
{
    
    class var CELL_REUSE_ID : String { return "MonthCell" }
    
    @IBOutlet var tableView:UITableView?
    
    private var date:NSDate = NSDate()
    private var monthHeader:CalendarMonthHeaderCell?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        //register week cell nib
        let weekNib:UINib = UINib(nibName: "CalendarWeekCell", bundle: nil)
        self.tableView?.registerNib(weekNib, forCellReuseIdentifier: CalendarWeekCell.CELL_REUSE_ID)
        self.tableView?.layoutMargins = UIEdgeInsetsZero
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView?.scrollEnabled = false
        self.tableView?.bounces = false
        
        //set month header
        let frame:CGRect = CGRectMake(0, 0, self.frame.width, CGFloat(CalendarConstants.CALENDAR_SIZE.MONTH_START_ROW_HEIGHT.rawValue))
        self.monthHeader = CalendarMonthHeaderCell(frame: frame)
        self.tableView?.tableHeaderView = self.monthHeader
    }
    
    //set the date for the month
    func setDate(date:NSDate) {
        self.date = date
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(self.getNumberOfRows(section))
    }
    
    private func getNumberOfRows(section:Int) -> CGFloat {
        let numWeeks:CGFloat = CGFloat(CalendarUtils.getNumberOfWeeksForMonth(self.date))
        return numWeeks
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let h:CGFloat = CGFloat(CalendarConstants.CALENDAR_SIZE.WEEK_ROW_HEIGHT.rawValue)
        return h
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:CalendarWeekCell = tableView.dequeueReusableCellWithIdentifier(CalendarWeekCell.CELL_REUSE_ID) as CalendarWeekCell
        cell.update(self.date, weekNum: indexPath.row)
        
        //for some reason header can only position correctly here
        self.monthHeader?.setMonth(self.date)
        
        return cell
    }
    
}