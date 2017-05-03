//
//  InstrumentationViewController.swift
//  Assignment4
//
//  Created by Van Simmons on 1/15/17.
//  Modified by Corbett Weinberg 4/17/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit
import Foundation

class InstrumentationViewController: UIViewController {
    
    var refreshRate = 5.0
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
        print("Cols \(Int(sender.value))")
    }
    
    @IBAction func sldRate(_ sender: UISlider) {
        let currentValue = Float(sender.value)/10;
        let roundedValue = round(currentValue / 0.1) * 0.1;
        lblRate.text = "Rate (\(roundedValue) hz)"
        refreshRate = 1/Double(roundedValue)
        print(refreshRate)
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
            //refreshLabel.text = "UISwitch is ON"
        } else {
            StandardEngine.engine.refreshRate = 0.0
            //refreshLabel.text = "UISwitch is OFF"
        }
    }
}

