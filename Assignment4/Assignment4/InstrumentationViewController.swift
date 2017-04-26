//
//  InstrumentationViewController.swift
//  Assignment4
//
//  Created by Van Simmons on 1/15/17.
//  Modified by Corbett Weinberg 4/17/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController {
    
    @IBAction func sldRate(_ sender: UISlider) {
        let currentValue = Float(sender.value)/10;
        let roundedValue = round(currentValue / 0.1) * 0.1;
        lblRate.text = "Rate (\(roundedValue) hz)"
    }
    
    @IBOutlet weak var lblRate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

