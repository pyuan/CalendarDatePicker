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
        var border:CALayer = CALayer()
        border.backgroundColor = CalendarConstants.COLOR_GREY.CGColor
        border.frame = CGRectMake(0, 0, self.frame.width, 1)
        self.layer.addSublayer(border)
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
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:CalendarDayCell = collectionView.dequeueReusableCellWithReuseIdentifier(CalendarDayCell.CELL_REUSE_ID, forIndexPath: indexPath) as CalendarDayCell
        return cell
    }
    
}