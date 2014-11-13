//
//  CalendarWeekCell.swift
//  CalendarDatePicker
//
//  Created by Paul Yuan on 2014-11-12.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

protocol CalendarWeekCellDelegate {
    func calendarWeekOnDaySelected(day:NSDate)
}

class CalendarWeekCell:UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    
    class var CELL_REUSE_ID : String { return "WeekCell" }
    class var NUM_DAYS_IN_WEEK : CGFloat { return 7 }
    
    @IBOutlet var collectionView:UICollectionView?
    
    var delegate:CalendarWeekCellDelegate?
    
    private var topBorder:CALayer?
    private var baseDate:NSDate = NSDate()
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
    
    func update(baseDate:NSDate, weekNum:Int) {
        self.baseDate = baseDate
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        //deselect all day in week
        self.deselectAllDays()
        
        //select cell
        var cell:CalendarDayCell = collectionView.cellForItemAtIndexPath(indexPath) as CalendarDayCell
        cell.updateSelected(true)
        
        //trigger delegate method
        var cellDate:NSDate? = cell.getDate()
        if cellDate != nil {
            self.delegate?.calendarWeekOnDaySelected(cellDate!)
            
            //update in singleton model
            CalendarModel.sharedInstance.selectedDate = cellDate!
        }
    }
    
    //select a day cell if it matches with the provided date
    func selectDayInWeek(date:NSDate)
    {
        let selectedDate:NSDate = CalendarModel.sharedInstance.selectedDate
        let cells:[CalendarDayCell] = self.collectionView?.visibleCells() as [CalendarDayCell]
        for i in 0..<cells.count
        {
            let cell:CalendarDayCell = cells[i]
            let cellDate:NSDate? = cell.getDate()
            if cellDate != nil
            {
                let sameDay:Bool = CalendarUtils.sameDay(cellDate!, date2: selectedDate)
                if sameDay
                {
                    let indexPath:NSIndexPath = NSIndexPath(forRow: i, inSection: 0)
                    self.collectionView?.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.None)
                    break
                }
            }
        }
    }
    
    //deselect all days in the week
    func deselectAllDays()
    {
        var cells:[CalendarDayCell] = self.collectionView?.visibleCells() as [CalendarDayCell]
        for cell in cells {
            cell.updateSelected(false)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell:CalendarDayCell = collectionView.dequeueReusableCellWithReuseIdentifier(CalendarDayCell.CELL_REUSE_ID, forIndexPath: indexPath) as CalendarDayCell
        
        //get current day for cell
        let cellDate:NSDate? = self.getCellDate(indexPath)
        cell.update(cellDate)
        
        //update top border for first and last weeks
        let numWeeksInMonth:Int = CalendarUtils.getNumberOfWeeksForMonth(self.baseDate)
        if self.weekNum == 0
        {
            let firstDay:NSDate = CalendarUtils.getFirstDayOfMonth(self.baseDate)
            let firstDayWeekDay:Int = CalendarUtils.getDayOfWeek(firstDay)
            let offset:Int = firstDayWeekDay - 1
            self.updateTopBorder(offset, offsetDaysRight: 0)
        }
        else if self.weekNum == numWeeksInMonth - 1
        {
            let lastDay:NSDate = CalendarUtils.getLastDayOfMonth(self.baseDate)
            let lastDayWeekDay:Int = CalendarUtils.getDayOfWeek(lastDay)
            let offset:Int = Int(CalendarWeekCell.NUM_DAYS_IN_WEEK) - lastDayWeekDay
            self.updateTopBorder(0, offsetDaysRight: offset)
        }
        
        return cell
    }
    
    //return date associated with a day cell by proiding a NSIndexPath
    private func getCellDate(indexPath:NSIndexPath) -> NSDate?
    {
        let numCells:Int = CalendarUtils.getNumCellsForMonth(self.baseDate)
        let numDaysInMonth:Int = CalendarUtils.getNumberOfDaysForMonth(self.baseDate)
        let numWeeksInMonth:Int = CalendarUtils.getNumberOfWeeksForMonth(self.baseDate)
        let cellIndex:Int = self.weekNum * Int(CalendarWeekCell.NUM_DAYS_IN_WEEK) + indexPath.row
        let firstDay:NSDate = CalendarUtils.getFirstDayOfMonth(self.baseDate)
        let firstDayWeekDay:Int = CalendarUtils.getDayOfWeek(firstDay)
        let numDaysFromFirstDay:Int = cellIndex - firstDayWeekDay + 1
        let cellDate:NSDate? = numDaysFromFirstDay < 0 || numDaysFromFirstDay >= numDaysInMonth ? nil : CalendarUtils.getDateRelativeToDate(firstDay, numDays: numDaysFromFirstDay)
        return cellDate
    }
    
}