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
        return 12
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return tableView.frame.height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:CalendarMonthCell = tableView.dequeueReusableCellWithIdentifier(CalendarMonthCell.CELL_REUSE_ID) as CalendarMonthCell
        return cell
    }
    
}