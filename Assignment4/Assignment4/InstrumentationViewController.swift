//
//  InstrumentationViewController.swift
//  Assignment4
//
//  Created by Van Simmons on 1/15/17.
//  Modified by Corbett Weinberg 4/17/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//
//  ************ No Attribution required for the icons ***************
//
//
/*
 Notes for me and you...
 A few things I'd love feedback on if you'd be so kind, even though some of it is kind of explained in discussion.
    - My grid doesn't change size if I change the row/col size on the instrumentation panel before 1st visiting Simulation.
        - How do I fix that?
    - Mentioned in discussion - Statistics don't update until I hit the Sim tab first.
    - If I update refreshRate wile refresh is on (by sliding the slider), it goes whack y and refreshes too fast.
    - I'm getting a Build time error (IB Designables - Failed to render and update auto layout status for SimulationView...
        In the crash file it indicates...
            "fatal error: unexpectedly found nil while unwrapping an Optional value
            1   edu.harvard.Assignment4       	0x00000002169a744f _TFFFC11Assignment45XView9drawOvalsFVSC6CGRectT_U_FSiT_U_FSiT_ + 303 (XView.swift:55)
            "
    Figured this sucker out... I had "gridDataSource" set to force unwrap instead of checking if it was nil. My storyboard wouldn't appear because of this (or it appeared, but Simulator was blank).

 */

import UIKit
import Foundation

class InstrumentationViewController: UIViewController {
    
    var refreshRate: Double = 5.0
    @IBOutlet weak var refreshLabel: UILabel!
    @IBOutlet weak var rowsTextBox: UITextField!
    @IBOutlet weak var colsTextBox: UITextField!
    
    @IBAction func rowsStepper(_ sender: UIStepper) {
        
        rowsTextBox.text = Int(sender.value).description
        StandardEngine.engine.rows = Int(sender.value)
    }
    @IBAction func colsStepper(_ sender: UIStepper) {
        
        colsTextBox.text = Int(sender.value).description
        StandardEngine.engine.cols = Int(sender.value)
    }
    
    @IBAction func sldRate(_ sender: UISlider) {
        let currentValue = Double(sender.value)/10;
        let roundedValue = round(currentValue / 0.1) * 0.1;
        refreshLabel.text = "Rate (\(roundedValue) hz)"
        refreshRate = roundedValue
        //StandardEngine.engine.refreshRate = refreshRate // This doesn't work. Causes the refresh rate to go nuts (like refreshes almost instantly). Not sure what I am doing wrong here.
        print("sldRate: \(refreshRate)")
    }
    
    @IBOutlet weak var lblRate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func refreshOnOff(_ sender: UISwitch) {
        if sender.isOn {
            StandardEngine.engine.refreshRate = refreshRate
        } else {
            StandardEngine.engine.refreshRate = 0.0
        }
    }
}

