//
//  CalendarDayCell.swift
//  CalendarDatePicker
//
//  Created by Paul Yuan on 2014-11-11.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class CalendarDayCell:UICollectionViewCell
{
    
    class var CELL_REUSE_ID:String { return "day" }
    
    @IBOutlet var label:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clearColor()
    }
    
}