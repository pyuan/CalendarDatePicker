//
//  ViewController.swift
//  CalendarDatePicker
//
//  Created by Paul Yuan on 2014-11-11.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CalendarDatePickerControllerDelegate, UITextFieldDelegate
{
    
    @IBOutlet var textField:UITextField?
    
    private var popoverController:UIPopoverController?
    private var datePickerController:CalendarDatePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textField?.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        /*
        let storyboard:UIStoryboard = UIStoryboard(name: "CalendarDatePicker", bundle: nil)
        let controller:UIViewController = storyboard.instantiateInitialViewController() as UIViewController
        self.navigationController?.presentViewController(controller, animated: true, completion: nil)
        */
    }
    
    func showDatePickerPopover(sender:AnyObject)
    {
        let storyboard:UIStoryboard = UIStoryboard(name: "CalendarDatePicker", bundle: nil)
        let nc:UINavigationController = storyboard.instantiateInitialViewController() as UINavigationController
        self.datePickerController = nc.viewControllers[0] as? CalendarDatePickerController
        self.datePickerController?.delegate = self
        self.popoverController = UIPopoverController(contentViewController: nc)
        self.popoverController!.setPopoverContentSize(CGSizeMake(300, 400), animated: true)
        self.popoverController!.presentPopoverFromRect((sender as UIView).frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.showDatePickerPopover(textField)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        let date:NSDate? = self.datePickerController!.getSelectedDate()
        self.textField?.text = date?.description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calendarDatePickerOnDaySelected(day: NSDate) {
        self.textField?.text = day.description
        self.popoverController?.dismissPopoverAnimated(true)
    }

}

