//
//  ViewController.swift
//  CalendarDatePicker
//
//  Created by Paul Yuan on 2014-11-11.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let storyboard:UIStoryboard = UIStoryboard(name: "CalendarDatePicker", bundle: nil)
        let controller:UIViewController = storyboard.instantiateInitialViewController() as UIViewController
        self.navigationController?.presentViewController(controller, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

