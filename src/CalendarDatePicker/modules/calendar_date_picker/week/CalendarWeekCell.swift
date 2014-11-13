//
//  CalendarWeekCell.swift
//  CalendarDatePicker
//
//  Created by Paul Yuan on 2014-11-12.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class CalendarWeekCell:UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    
    class var CELL_REUSE_ID : String { return "WeekCell" }
    class var NUM_DAYS_IN_WEEK : CGFloat { return 7 }
    
    @IBOutlet var collectionView:UICollectionView?
    
    private var topBorder:CALayer?
    private var date:NSDate = NSDate()
    private var weekNum:Int = 0
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        //load days of the week
        var nib:UINib = UINib(nibName: "CalendarDayCell", bundle: nil)
        self.collectionView?.registerNib(nib, forCellWithReuseIdentifier: CalendarDayCell.CELL_REUSE_ID)
        self.collectionView?.backgroundColor = UIColor.clearColor()
        self.collectionView?.bounces = false
        self.collectionView?.scrollEnabled = false
        
        //draw top border
        self.topBorder = CALayer()
        self.topBorder!.backgroundColor = CalendarConstants.COLOR_LIGHT_GREY.CGColor
        self.updateTopBorder(0, offsetDaysRight: 0)
        self.layer.addSublayer(self.topBorder!)
    }
    
    func update(date:NSDate, weekNum:Int) {
        self.date = date
        self.weekNum = weekNum
    }
    
    //draw the border starting from the specified offset days
    private func updateTopBorder(offsetDaysLeft:Int, offsetDaysRight:Int)
    {
        let dayWidth:CGFloat = self.frame.width / CalendarWeekCell.NUM_DAYS_IN_WEEK
        let x:CGFloat = CGFloat(offsetDaysLeft) * dayWidth
        let w:CGFloat = self.frame.width - x - (CGFloat(offsetDaysRight) * dayWidth)
        self.topBorder!.frame = CGRectMake(x, 0, w, 1)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let w:CGFloat = collectionView.frame.width / CalendarWeekCell.NUM_DAYS_IN_WEEK
        let h:CGFloat = collectionView.frame.height
        return CGSizeMake(w, h)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell:CalendarDayCell = collectionView.dequeueReusableCellWithReuseIdentifier(CalendarDayCell.CELL_REUSE_ID, forIndexPath: indexPath) as CalendarDayCell
        
        //get current day for cell
        let numCells:Int = CalendarUtils.getNumCellsForMonth(self.date)
        let numDaysInMonth:Int = CalendarUtils.getNumberOfDaysForMonth(self.date)
        let numWeeksInMonth:Int = CalendarUtils.getNumberOfWeeksForMonth(self.date)
        let cellIndex:Int = self.weekNum * Int(CalendarWeekCell.NUM_DAYS_IN_WEEK) + indexPath.row
        let firstDay:NSDate = CalendarUtils.getFirstDayOfMonth(self.date)
        let firstDayWeekDay:Int = CalendarUtils.getDayOfWeek(firstDay)
        let numDaysFromFirstDay:Int = cellIndex - firstDayWeekDay + 1
        let cellDate:NSDate? = numDaysFromFirstDay < 0 || numDaysFromFirstDay >= numDaysInMonth ? nil : CalendarUtils.getDateRelativeToDate(firstDay, numDays: numDaysFromFirstDay)
        cell.update(cellDate)
        
        //update top border for first and last weeks
        if self.weekNum == 0
        {
            let offset:Int = firstDayWeekDay - 1
            self.updateTopBorder(offset, offsetDaysRight: 0)
        }
        else if self.weekNum == numWeeksInMonth - 1
        {
            let lastDay:NSDate = CalendarUtils.getLastDayOfMonth(self.date)
            let lastDayWeekDay:Int = CalendarUtils.getDayOfWeek(lastDay)
            let offset:Int = Int(CalendarWeekCell.NUM_DAYS_IN_WEEK) - lastDayWeekDay
            self.updateTopBorder(0, offsetDaysRight: offset)
        }
        
        return cell
    }
    
}